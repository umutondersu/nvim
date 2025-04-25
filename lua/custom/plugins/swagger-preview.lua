return {
    "vinnymeller/swagger-preview.nvim",
    enabled = vim.fn.getenv("REMOTE_CONTAINERS") ~= 'true',
    build = "npm i",
    cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
    opts = {}
}
