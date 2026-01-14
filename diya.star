"""
Diya Flame - A flickering Indian oil lamp animation for Tidbyt
Displays a top-down angled view of a diya with an animated flame
"""

load("render.star", "render")
load("animation.star", "animation")
load("math.star", "math")

# Color palette
FLAME_YELLOW = "#FFD700"
FLAME_ORANGE = "#FF8C00"
FLAME_RED = "#FF4500"
FLAME_WHITE = "#FFFACD"
FLAME_LIGHT_ORANGE = "#FFB347"
DIYA_BROWN = "#8B4513"
DIYA_TERRACOTTA = "#E2725B"
DIYA_DARK = "#654321"
DIYA_HIGHLIGHT = "#CD853F"
OIL_YELLOW = "#FFA500"
OIL_DARK = "#CC8400"
BACKGROUND = "#1a0f0a"

def draw_diya():
    """Draw the diya lamp body with distinctive teardrop/leaf shape from top-down angle"""
    return [
        # Back/rounded bottom of diya (wider)
        render.Padding(
            pad=(14, 26, 0, 0),
            child=render.Box(width=36, height=3, color=DIYA_DARK),
        ),
        render.Padding(
            pad=(12, 24, 0, 0),
            child=render.Box(width=40, height=2, color=DIYA_BROWN),
        ),
        # Widest part of body
        render.Padding(
            pad=(10, 22, 0, 0),
            child=render.Box(width=44, height=2, color=DIYA_TERRACOTTA),
        ),
        render.Padding(
            pad=(12, 20, 0, 0),
            child=render.Box(width=40, height=2, color=DIYA_BROWN),
        ),
        # Tapering toward spout
        render.Padding(
            pad=(16, 18, 0, 0),
            child=render.Box(width=32, height=2, color=DIYA_TERRACOTTA),
        ),
        render.Padding(
            pad=(20, 16, 0, 0),
            child=render.Box(width=24, height=2, color=DIYA_BROWN),
        ),
        # Pointed spout where wick sits
        render.Padding(
            pad=(24, 14, 0, 0),
            child=render.Box(width=16, height=2, color=DIYA_DARK),
        ),
        render.Padding(
            pad=(28, 12, 0, 0),
            child=render.Box(width=8, height=2, color=DIYA_TERRACOTTA),
        ),

        # Inner oil surface (follows teardrop shape)
        render.Padding(
            pad=(18, 25, 0, 0),
            child=render.Box(width=28, height=2, color=OIL_DARK),
        ),
        render.Padding(
            pad=(16, 23, 0, 0),
            child=render.Box(width=32, height=2, color=OIL_YELLOW),
        ),
        render.Padding(
            pad=(20, 21, 0, 0),
            child=render.Box(width=24, height=2, color=OIL_DARK),
        ),
        render.Padding(
            pad=(24, 19, 0, 0),
            child=render.Box(width=16, height=2, color=OIL_YELLOW),
        ),

        # Rim highlights for depth
        render.Padding(
            pad=(16, 22, 0, 0),
            child=render.Box(width=32, height=1, color=DIYA_HIGHLIGHT),
        ),

        # Wick at the pointed end
        render.Padding(
            pad=(30, 14, 0, 0),
            child=render.Box(width=4, height=6, color=DIYA_DARK),
        ),
    ]

def draw_flame(frame):
    """Draw animated flame with more realistic flickering"""
    # Slower flickering pattern with pseudo-random variation
    # Using multiple overlapping cycles for organic feel
    cycle1 = frame % 16  # Doubled from 8 for slower movement
    cycle2 = (frame * 2) % 13  # Reduced multiplier for slower cycle
    cycle3 = (frame * 3) % 17  # Reduced multiplier for slower cycle

    # Combine cycles for pseudo-random but repeating flicker
    flicker_intensity = (cycle1 + (cycle2 % 3) + (cycle3 % 2)) % 6

    # Vary flame dimensions based on flicker - BIGGER SIZES
    if flicker_intensity == 0:
        height1, height2, height3 = 16, 12, 7
        offset = -2
        width1, width2 = 9, 7
    elif flicker_intensity == 1:
        height1, height2, height3 = 14, 10, 6
        offset = -1
        width1, width2 = 8, 6
    elif flicker_intensity == 2:
        height1, height2, height3 = 15, 11, 7
        offset = -1
        width1, width2 = 9, 7
    elif flicker_intensity == 3:
        height1, height2, height3 = 13, 10, 6
        offset = 0
        width1, width2 = 8, 6
    elif flicker_intensity == 4:
        height1, height2, height3 = 17, 13, 8
        offset = -3
        width1, width2 = 10, 7
    else:
        height1, height2, height3 = 14, 11, 6
        offset = -1
        width1, width2 = 8, 6

    # Horizontal sway with smoother, slower variation
    sway_val = math.sin(float(frame) * 0.15) * 1.5  # Reduced from 0.3 for slower sway
    sway = int(sway_val)

    # Slight shape variation (wider/narrower)
    if cycle2 % 4 == 0:
        width1 += 1

    return [
        # Outer flame glow (red-orange)
        render.Padding(
            pad=(28 + sway, 20 - height1 + offset, 0, 0),
            child=render.Box(width=width1, height=height1, color=FLAME_RED),
        ),
        # Middle flame (orange)
        render.Padding(
            pad=(29 + sway, 20 - height2 + offset, 0, 0),
            child=render.Box(width=width2, height=height2, color=FLAME_ORANGE),
        ),
        # Bright inner flame (light orange)
        render.Padding(
            pad=(30 + sway, 20 - (height2 - 1) + offset, 0, 0),
            child=render.Box(width=width2 - 1, height=height2 - 2, color=FLAME_LIGHT_ORANGE),
        ),
        # Hot center (yellow)
        render.Padding(
            pad=(30 + sway, 20 - height3 + offset, 0, 0),
            child=render.Box(width=4, height=height3, color=FLAME_YELLOW),
        ),
        # Flame tip (bright white - flickers on and off)
        render.Padding(
            pad=(31 + sway, 20 - height1 + offset - 1, 0, 0),
            child=render.Box(
                width=3,
                height=3 if flicker_intensity in [0, 4] else 2,
                color=FLAME_WHITE
            ),
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
        delay=150,  # 150ms per frame for slower, more relaxed animation
        child=render.Animation(children=frames),
    )
