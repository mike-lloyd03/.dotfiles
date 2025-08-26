import threading

from pathlib import Path
from typing import Any

from kitty.boss import Boss
from kitty.window import Window
from kitty.fast_data_types import current_os_window




def write_session(boss: Boss, session_name: str, blocking: bool = False):
    path = Path(f"~/.config/kitty/sessions/{session_name}").expanduser()

    lock = threading.Lock()
    locked = lock.acquire(blocking=blocking)
    if not locked:
        return
    try:
        with open(path, "w") as f:
            f.write("\n".join(boss.serialize_state_as_session()))
    finally:
        lock.release()

def on_tab_bar_dirty(boss: Boss, window: Window, data: dict[str, Any]) -> None:
    current_os_window_id = current_os_window()
    os_windows = boss.list_os_windows()

    for os_window in os_windows:
        print(f"checking window {os_window['id']}")
        if os_window['id'] == current_os_window_id:
            wname = os_window['wm_name']
            print(f"got wm_name {wname}")
            session_name_parts = wname.split("_", 1)
            if len(session_name_parts) > 1:
                    if session_name_parts[0] == "kitty":
                        write_session(boss, session_name_parts[1])
                        print(f"wrote session {session_name_parts[1]}")
