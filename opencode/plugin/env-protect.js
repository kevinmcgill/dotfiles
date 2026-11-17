export default {
  id: "env-protect",
  async setup(ctx) {
    await ctx.tool.hook("execute.before", (event) => {
      const path = event.input?.path ?? event.input?.filePath
      if (event.tool === "read" && path?.includes(".env")) {
        throw new Error("Do not read .env files")
      }
    })
  },
}
