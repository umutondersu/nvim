return {
    "vinnymeller/swagger-preview.nvim",
    enabled = vim.fn.getenv("REMOTE_CONTAINERS") ~= 'true',
    build = "npm install -g swagger-ui-watcher",
    cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
    opts = {},
    ft = "yaml"
}
