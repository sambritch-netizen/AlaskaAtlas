import json
import os
from datetime import datetime
from pathlib import Path

import anthropic
import pytz

ET = pytz.timezone("America/New_York")
MODEL = "claude-sonnet-4-6"
CLAUDE_MD = Path(__file__).parent.parent / "CLAUDE.md"


class TradingAgent:
    def __init__(self):
        self.client = anthropic.Anthropic(api_key=os.getenv("ANTHROPIC_API_KEY"))
        self.daily_plan: dict = {}
        self.session_trades: list[dict] = []

    def _system_prompt(self) -> str:
        return CLAUDE_MD.read_text() if CLAUDE_MD.exists() else ""

    def _call(self, prompt: str, max_tokens: int = 1024) -> str:
        response = self.client.messages.create(
            model=MODEL,
            max_tokens=max_tokens,
            system=self._system_prompt(),
            messages=[{"role": "user", "content": prompt}],
        )
        return response.content[0].text

    def morning_study(self, market_context: dict) -> dict:
        """Claude reads market context and produces the daily trading plan."""
        now_str = datetime.now(ET).strftime("%A, %B %d, %Y at %I:%M %p ET")
        prompt = (
            f"It is {now_str}. Perform your morning market study and return your daily trading plan.\n\n"
            f"Market context:\n{json.dumps(market_context, indent=2)}\n\n"
            "Respond with valid JSON only — no markdown, no extra text."
        )
        raw = self._call(prompt, max_tokens=1024)
        try:
            plan = json.loads(raw)
        except json.JSONDecodeError:
            plan = {"market_bias": "neutral", "notes": raw, "parse_error": True}
        self.daily_plan = plan
        return plan

    def make_trading_decisions(
        self,
        candidates: list[dict],
        market_context: dict,
        positions: list,
        account,
    ) -> list[dict]:
        """Claude evaluates scored candidates and returns buy/hold decisions."""
        if not candidates:
            return []

        account_info = {
            "buying_power": float(account.buying_power),
            "portfolio_value": float(account.portfolio_value),
            "open_positions": len(positions),
            "position_symbols": [p.symbol for p in positions],
        }

        now_str = datetime.now(ET).strftime("%I:%M %p ET")
        prompt = (
            f"Time: {now_str}\n\n"
            f"Daily Plan:\n{json.dumps(self.daily_plan, indent=2)}\n\n"
            f"Account:\n{json.dumps(account_info, indent=2)}\n\n"
            f"Market Context:\n{json.dumps(market_context, indent=2)}\n\n"
            f"Scored Candidates (best first):\n{json.dumps(candidates, indent=2)}\n\n"
            "Decide which candidates (if any) to buy. Remember: max 3 positions, max $100 risk per trade, "
            "long only, do not trade stocks already held.\n"
            "Respond with valid JSON only — no markdown, no extra text."
        )
        raw = self._call(prompt, max_tokens=2048)
        try:
            result = json.loads(raw)
        except json.JSONDecodeError:
            print(f"[agent] Decision parse error: {raw[:300]}")
            return []

        if "market_assessment" in result:
            self.daily_plan["market_assessment"] = result["market_assessment"]

        return result.get("decisions", [])

    def write_journal(self, trades: list[dict], market_context: dict) -> Path:
        """Write an end-of-day journal entry and return the file path."""
        today = datetime.now(ET).strftime("%Y-%m-%d")
        prompt = (
            f"Write your end-of-day trading journal for {today}.\n\n"
            f"Daily Plan:\n{json.dumps(self.daily_plan, indent=2)}\n\n"
            f"Trades Taken:\n{json.dumps(trades, indent=2)}\n\n"
            f"Market Context:\n{json.dumps(market_context, indent=2)}\n\n"
            "Cover all required journal sections in plain text. Be honest about mistakes."
        )
        text = self._call(prompt, max_tokens=2048)

        journal_dir = Path(__file__).parent.parent / "journal"
        journal_dir.mkdir(exist_ok=True)
        path = journal_dir / f"{today}.md"
        path.write_text(f"# Trading Journal — {today}\n\n{text}")
        return path
