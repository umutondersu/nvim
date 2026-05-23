return {
    "vinnymeller/swagger-preview.nvim",
    cond = vim.fn.executable("npm") == 1,
    enabled = vim.fn.getenv("REMOTE_CONTAINERS") ~= 'true',
    build = "npm i",
    cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
    ft = { "yaml", "json" },
    opts = {}
}
