import os
from pathlib import Path

from kitty.boss import Boss
from kitty.fast_data_types import get_options
from kitty.session import create_sessions
from kitty.fast_data_types import current_os_window


def main(args: list[str]) -> str:
    sessions_dir = Path("~/.config/kitty/sessions").expanduser()
    sessions = os.listdir(sessions_dir)
    files = [f for f in sessions if os.path.isfile(os.path.join(sessions_dir, f))]

    print("Choose a session file:")
    for index, filename in enumerate(files):
        print(f"  [{index + 1}] {filename}")

    while True:
        try:
            choice = input(f"\nEnter a number (1-{len(files)}): ")
            choice_index = int(choice) - 1

            if 0 <= choice_index < len(files):
                selected_file_path = os.path.join(sessions_dir, files[choice_index])
                print(selected_file_path)
                return selected_file_path
            else:
                print("Invalid selection.")

        except ValueError:
            print("Invalid input.")
        except KeyboardInterrupt:
            return ""

def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    if answer == '':
        return

    current_os_window_id = current_os_window()

    startup_sessions = tuple(create_sessions(get_options(), None, default_session=answer))

    boss.mark_os_window_for_close(current_os_window_id)
    # boss.new_tab()
    # boss.close_other_tabs_in_os_window()
    for startup_session in startup_sessions:
        # boss.add_os_window(startup_session, os_window_id=current_os_window_id)
        boss.add_os_window(startup_session, wname=f"kitty_{answer}")

    return
