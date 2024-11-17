return {
    "vinnymeller/swagger-preview.nvim",
    enabled = false,
    build = "npm install -g swagger-ui-watcher",
    cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
    opts = {},
    ft = "yaml"
}
