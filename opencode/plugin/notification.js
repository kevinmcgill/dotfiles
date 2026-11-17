import { execFile } from "node:child_process"

export default {
  id: "notification",
  setup(ctx) {
    const controller = new AbortController()

    void (async () => {
      const events = ctx.event.subscribe({
        types: ["session.execution.succeeded"],
        signal: controller.signal,
      })
      for await (const event of events) {
        if (event.type !== "session.execution.succeeded") continue
        // Skip subagent sessions, notify only for top-level sessions
        const session = await ctx.session.get({ sessionID: event.data.sessionID }).catch(() => undefined)
        if (session?.parentID) continue
        execFile("osascript", ["-e", 'display notification "Session completed!" with title "opencode"'])
      }
    })()

    return () => controller.abort()
  },
}
