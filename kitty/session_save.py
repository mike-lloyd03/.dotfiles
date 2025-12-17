from typing import Any

from kitty.boss import Boss
from kitty.fast_data_types import add_timer
from kitty.session import default_save_as_session_opts, save_as_session_part2

SESSION_DIR = "/home/mike/.config/kitty/sessions/"


def _save_as_session(boss: Boss) -> None:
    session = boss.active_session
    if session:
        print(f"saving session {session}")
        opts = default_save_as_session_opts()
        opts.save_only = True
        save_as_session_part2(boss, opts, SESSION_DIR + session)


def on_load(boss: Boss, _data: dict[str, Any]):
    add_timer(lambda _: _save_as_session(boss), 60, True)
