return {
    "vinnymeller/swagger-preview.nvim",
    cond = require('kickstart.util.conditions').npm(),
    enabled = vim.fn.getenv("REMOTE_CONTAINERS") ~= 'true',
    build = "npm i",
    cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
    ft = { "yaml", "json" },
    opts = {}
}
