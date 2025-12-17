
from kitty.boss import get_boss
from kitty.fast_data_types import Screen
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
)
from kitty.rgb import to_color

WHITE = to_color("#fff")
ORANGE = to_color("#e2b86b")
TEXT = to_color("#1a1c23")


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    default_bg = as_rgb(int(draw_data.default_bg))

    if tab.is_active:
        index_bg = as_rgb(int(draw_data.active_bg))
        index_fg = as_rgb(int(draw_data.active_fg))
        tab_bg = as_rgb(int(WHITE))
        tab_fg = index_fg
    else:
        tab_bg = as_rgb(int(draw_data.inactive_bg))
        tab_fg = as_rgb(int(draw_data.inactive_fg))
        index_bg = tab_bg
        index_fg = tab_fg

    if before != 0:
        screen.cursor.bg = default_bg
        screen.cursor.fg = index_bg
        screen.draw("")

    screen.cursor.bg = index_bg
    screen.cursor.fg = index_fg
    screen.cursor.bold = tab.is_active
    screen.draw(f" {index} ")
    screen.cursor.bold = False

    if tab.is_active:
        screen.cursor.bg = tab_bg
        screen.cursor.fg = index_bg
        screen.draw("")
    else:
        screen.draw("")

    screen.cursor.bg = tab_bg
    screen.cursor.fg = tab_fg
    screen.cursor.bold = tab.is_active
    screen.draw(f" {tab.title}")
    screen.cursor.bold = False
    if tab.layout_name == "stack":
        screen.draw(" z")
    screen.draw(" ")

    screen.cursor.bg = default_bg
    screen.cursor.fg = tab_bg
    screen.draw("")

    if is_last:
        _draw_right_status(draw_data, screen, tab)
    return screen.cursor.x


def _draw_right_status(draw_data: DrawData, screen: Screen, tab: TabBarData) -> int:
    boss = get_boss()

    layout_name = tab.layout_name
    if layout_name == "fat":
        layout_name = "wide"

    session_name = boss.active_session
    if not session_name:
        session_name = "none"

    mode = boss.mappings.current_keyboard_mode_name
    if mode != "":
        if mode == "__sequence__":
            mode = "pending"

        cells = [
            (ORANGE, draw_data.default_bg, ""),
            (TEXT, ORANGE, f" {mode} "),
            (ORANGE, WHITE, ""),
            (draw_data.active_fg, WHITE, f" {layout_name} "),
        ]
    else:
        cells = [
            (WHITE, draw_data.default_bg, ""),
            (draw_data.active_fg, WHITE, f" {layout_name} "),
        ]
        
    if session_name:
        cells.append((draw_data.active_bg, WHITE, ""))
        cells.append((draw_data.active_fg, draw_data.active_bg, f" {session_name} "))

    right_status_length = 0
    for _, _, cell in cells:
        right_status_length += len(cell)

    draw_spaces = screen.columns - screen.cursor.x - right_status_length
    if draw_spaces > 0:
        screen.draw(" " * draw_spaces)
    else:
        return screen.cursor.x

    for fg, bg, cell in cells:
        screen.cursor.fg = as_rgb(int(fg))
        screen.cursor.bg = as_rgb(int(bg))
        screen.draw(cell)
    screen.cursor.fg = 0
    screen.cursor.bg = 0

    screen.cursor.x = max(screen.cursor.x, screen.columns - right_status_length)
    return screen.cursor.x
