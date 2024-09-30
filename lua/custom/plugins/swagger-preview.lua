return {
    "vinnymeller/swagger-preview.nvim",
    build = "npm install -g swagger-ui-watcher",
    cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
    opts = {},
    ft = "yaml"
}
