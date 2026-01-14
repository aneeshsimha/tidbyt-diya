"""
Diya Flame - A flickering Indian oil lamp animation for Tidbyt
Displays a traditional diya with an animated flame and glow effect
"""

load("render.star", "render")
load("animation.star", "animation")
load("math.star", "math")

# Color palette - warm terracotta and flame colors
FLAME_WHITE = "#FFFACD"
FLAME_YELLOW = "#FFD700"
FLAME_LIGHT_ORANGE = "#FFB347"
FLAME_ORANGE = "#FF8C00"
FLAME_RED = "#FF4500"
GLOW_SOFT = "#FF6B3520"
GLOW_WARM = "#FFA50030"

# Clay/terracotta colors
CLAY_LIGHT = "#E07B53"
CLAY_MID = "#CD5C39"
CLAY_DARK = "#8B4513"
CLAY_SHADOW = "#5D3A1A"
CLAY_RIM = "#D2691E"

# Oil
OIL_SURFACE = "#FFB347"
OIL_DARK = "#CC8400"

BACKGROUND = "#0d0805"

def draw_diya():
    """Draw traditional diya - side/3D view with rounded bowl and spout"""
    return [
        # Base/bottom of diya
        render.Padding(
            pad=(20, 28, 0, 0),
            child=render.Box(width=24, height=2, color=CLAY_SHADOW),
        ),

        # Main bowl - rounded shape (side view)
        # Bottom curve
        render.Padding(
            pad=(18, 26, 0, 0),
            child=render.Box(width=28, height=2, color=CLAY_DARK),
        ),
        # Lower body
        render.Padding(
            pad=(16, 24, 0, 0),
            child=render.Box(width=32, height=2, color=CLAY_MID),
        ),
        # Middle body (widest)
        render.Padding(
            pad=(14, 22, 0, 0),
            child=render.Box(width=36, height=2, color=CLAY_LIGHT),
        ),
        # Upper body
        render.Padding(
            pad=(15, 20, 0, 0),
            child=render.Box(width=34, height=2, color=CLAY_MID),
        ),

        # Rim of the diya
        render.Padding(
            pad=(14, 19, 0, 0),
            child=render.Box(width=36, height=1, color=CLAY_RIM),
        ),

        # Spout extension (where wick goes) - extends to the right
        render.Padding(
            pad=(48, 20, 0, 0),
            child=render.Box(width=6, height=2, color=CLAY_MID),
        ),
        render.Padding(
            pad=(52, 19, 0, 0),
            child=render.Box(width=4, height=1, color=CLAY_RIM),
        ),
        render.Padding(
            pad=(54, 18, 0, 0),
            child=render.Box(width=3, height=1, color=CLAY_DARK),
        ),

        # Oil inside the bowl
        render.Padding(
            pad=(17, 20, 0, 0),
            child=render.Box(width=30, height=2, color=OIL_DARK),
        ),
        render.Padding(
            pad=(18, 20, 0, 0),
            child=render.Box(width=28, height=1, color=OIL_SURFACE),
        ),

        # Wick coming out of spout
        render.Padding(
            pad=(54, 16, 0, 0),
            child=render.Box(width=2, height=3, color=CLAY_SHADOW),
        ),
    ]

def draw_glow(frame):
    """Draw soft glow around flame"""
    cycle = frame % 8

    # Pulsing glow effect
    if cycle < 4:
        glow_size = 16
    else:
        glow_size = 14

    return [
        # Outer glow
        render.Padding(
            pad=(48, 16 - glow_size, 0, 0),
            child=render.Box(width=glow_size, height=glow_size, color="#FF450015"),
        ),
        # Inner glow
        render.Padding(
            pad=(50, 16 - glow_size + 2, 0, 0),
            child=render.Box(width=glow_size - 4, height=glow_size - 2, color="#FF8C0020"),
        ),
    ]

def draw_flame(frame):
    """Draw animated flame with realistic flickering"""
    # Slow, organic flickering pattern
    cycle1 = frame % 16
    cycle2 = (frame * 2) % 11

    flicker = (cycle1 + cycle2) % 6

    # Flame dimensions - tall teardrop shape
    if flicker == 0:
        h1, h2, h3, h4 = 14, 11, 8, 4
        w1, w2 = 8, 6
    elif flicker == 1:
        h1, h2, h3, h4 = 12, 9, 6, 3
        w1, w2 = 7, 5
    elif flicker == 2:
        h1, h2, h3, h4 = 13, 10, 7, 4
        w1, w2 = 8, 6
    elif flicker == 3:
        h1, h2, h3, h4 = 11, 8, 6, 3
        w1, w2 = 7, 5
    elif flicker == 4:
        h1, h2, h3, h4 = 15, 12, 9, 5
        w1, w2 = 8, 6
    else:
        h1, h2, h3, h4 = 12, 10, 7, 4
        w1, w2 = 7, 5

    # Gentle sway
    sway = int(math.sin(float(frame) * 0.12) * 1.2)

    # Flame position (at the wick/spout)
    base_x = 52
    base_y = 16

    return [
        # Outer flame (deep red-orange)
        render.Padding(
            pad=(base_x + sway, base_y - h1, 0, 0),
            child=render.Box(width=w1, height=h1, color=FLAME_RED),
        ),
        # Middle-outer flame (orange)
        render.Padding(
            pad=(base_x + 1 + sway, base_y - h2, 0, 0),
            child=render.Box(width=w2, height=h2, color=FLAME_ORANGE),
        ),
        # Middle flame (light orange)
        render.Padding(
            pad=(base_x + 1 + sway, base_y - h3, 0, 0),
            child=render.Box(width=w2 - 1, height=h3, color=FLAME_LIGHT_ORANGE),
        ),
        # Inner flame (bright yellow)
        render.Padding(
            pad=(base_x + 2 + sway, base_y - h4 - 1, 0, 0),
            child=render.Box(width=4, height=h4, color=FLAME_YELLOW),
        ),
        # Hottest center (white)
        render.Padding(
            pad=(base_x + 2 + sway, base_y - h4 + 1, 0, 0),
            child=render.Box(width=3, height=h4 - 2 if h4 > 3 else 2, color=FLAME_WHITE),
        ),
        # Flame tip
        render.Padding(
            pad=(base_x + 2 + sway, base_y - h1 - 1, 0, 0),
            child=render.Box(width=2, height=2, color=FLAME_ORANGE),
        ),
    ]

def main():
    """Main app entry point"""

    frames = []
    for i in range(32):
        frame_elements = [
            render.Box(width=64, height=32, color=BACKGROUND),
        ] + draw_glow(i) + draw_diya() + draw_flame(i)

        frames.append(
            render.Stack(children=frame_elements)
        )

    return render.Root(
        delay=150,  # Slower, relaxed animation
        child=render.Animation(children=frames),
    )
