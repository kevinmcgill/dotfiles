# frozen_string_literal: true

# Customise rails console prompt.
# If you want your own personal customisations, edit ~/.irbrc in your home dir.

# Use autocomplete in dev but not staging/prod as I assume it'll be annoying over Teleport.
# It could be disabled in development even if it turns out annoying.
require "irb/completion"
IRB.conf[:USE_AUTOCOMPLETE] = ENV["RAILS_ENV"] == "development"

# configure autocomplete dialog colors
if defined? Reline::Face
  Reline::Face.config(:completion_dialog) do |conf|
    conf.define(:default, foreground: "#cad3f5", background: "#363a4f")
    conf.define(:enhanced, foreground: "#cad3f5", background: "#5b6078")
    conf.define(:scrollbar, foreground: "#c6a0f6", background: "#181926")
  end
end

# Don't save history on staging/prod as it's an ephemeral read-only filesystem.
if ENV["RAILS_ENV"] != "development"
  IRB.conf[:SAVE_HISTORY] = nil # Override default 1000 line history.
end

# Set a custom env that makes it clearer which environment we're in, as a tiny bit of protection
# against someone accidentally running a command in the wrong environment.
env_prompt = %w[dev stag prod test].find { |env_short_name| ENV["RAILS_ENV"].slice(env_short_name) }
IRB.conf[:PROMPT][:ENV_SAFETY_PROMPT] = {
  AUTO_INDENT: true, # enables auto-indent mode
  PROMPT_I: env_prompt + "> ", # simple prompt
  PROMPT_S: env_prompt + "> ",                        # prompt for continuated strings
  PROMPT_C: env_prompt + "> ",                        # prompt for continuated statement
  RETURN: "=> %s\n"                     # format to return value
}
IRB.conf[:PROMPT_MODE] = :ENV_SAFETY_PROMPT
