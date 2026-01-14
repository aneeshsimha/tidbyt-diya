"""
Diya Flame - A flickering Indian oil lamp animation for Tidbyt
Displays a front-facing diya with an animated flame
"""

load("render.star", "render")
load("animation.star", "animation")

# Color palette
FLAME_YELLOW = "#FFD700"
FLAME_ORANGE = "#FF8C00"
FLAME_RED = "#FF4500"
FLAME_WHITE = "#FFFACD"
DIYA_BROWN = "#8B4513"
DIYA_TERRACOTTA = "#E2725B"
DIYA_DARK = "#654321"
OIL_YELLOW = "#FFA500"
BACKGROUND = "#1a0f0a"

def draw_diya():
    """Draw the diya lamp body"""
    return [
        # Diya body - bowl shape
        render.Box(width=20, height=3, color=DIYA_BROWN),
        render.Padding(
            pad=(18, 21, 0, 0),
            child=render.Box(width=28, height=4, color=DIYA_TERRACOTTA),
        ),
        render.Padding(
            pad=(16, 25, 0, 0),
            child=render.Box(width=32, height=3, color=DIYA_BROWN),
        ),
        # Diya rim
        render.Padding(
            pad=(14, 28, 0, 0),
            child=render.Box(width=36, height=2, color=DIYA_DARK),
        ),
        # Oil surface
        render.Padding(
            pad=(20, 26, 0, 0),
            child=render.Box(width=24, height=2, color=OIL_YELLOW),
        ),
        # Wick base
        render.Padding(
            pad=(30, 22, 0, 0),
            child=render.Box(width=4, height=4, color=DIYA_DARK),
        ),
    ]

def draw_flame(frame):
    """Draw animated flame with flickering effect"""
    # Create flickering pattern by varying flame height and shape
    flicker = frame % 12

    # Flame heights vary for flickering effect
    if flicker < 3:
        height1, height2, height3 = 8, 6, 3
        offset = 0
    elif flicker < 6:
        height1, height2, height3 = 10, 7, 4
        offset = -1
    elif flicker < 9:
        height1, height2, height3 = 9, 6, 3
        offset = 0
    else:
        height1, height2, height3 = 11, 8, 4
        offset = -2

    # Slight horizontal sway
    sway = 0
    if flicker in [2, 3, 8, 9]:
        sway = 1
    elif flicker in [5, 6, 11]:
        sway = -1

    return [
        # Outer flame (red-orange)
        render.Padding(
            pad=(29 + sway, 22 - height1 + offset, 0, 0),
            child=render.Box(width=6, height=height1, color=FLAME_RED),
        ),
        # Middle flame (orange)
        render.Padding(
            pad=(30 + sway, 22 - height2 + offset, 0, 0),
            child=render.Box(width=4, height=height2, color=FLAME_ORANGE),
        ),
        # Inner flame (yellow-white)
        render.Padding(
            pad=(31 + sway, 22 - height3 + offset, 0, 0),
            child=render.Box(width=2, height=height3, color=FLAME_YELLOW),
        ),
        # Flame tip (bright white)
        render.Padding(
            pad=(31 + sway, 22 - height1 + offset - 1, 0, 0),
            child=render.Box(width=2, height=2, color=FLAME_WHITE),
        ),
    ]

def main():
    """Main app entry point"""

    # Create animation frames
    frames = []
    for i in range(24):
        frame_elements = [
            render.Box(width=64, height=32, color=BACKGROUND),
        ] + draw_diya() + draw_flame(i)

        frames.append(
            render.Stack(children=frame_elements)
        )

    return render.Root(
        delay=100,  # 100ms per frame for smooth animation
        child=render.Animation(children=frames),
    )
