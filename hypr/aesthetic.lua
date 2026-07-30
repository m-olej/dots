hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 1,
        col = {
            active_border = "rgba(303030ee)",
            inactive_border = "rgba(0f0f0fee)"
        },
        layout = "dwindle",
        allow_tearing = false
    },
    decoration = {
        rounding = 4,
        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            new_optimizations = true,
            ignore_opacity = true
        },
        shadow = {
            enabled = true,
            range = 8,
            render_power = 3,
            color = "rgba(000000aa)"
        }
    }
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Animation curves and definitions
hl.curve("fluent", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.0} } })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "fluent", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "default" })
