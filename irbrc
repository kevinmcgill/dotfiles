# frozen_string_literal: true

# Customise rails console prompt.
require "irb/completion"

IRB.conf[:EVAL_HISTORY] = 10

# configure autocomplete dialog colors
if defined? Reline::Face
  Reline::Face.config(:completion_dialog) do |conf|
    conf.define(:default, foreground: "#cad3f5", background: "#363a4f")
    conf.define(:enhanced, foreground: "#cad3f5", background: "#5b6078")
    conf.define(:scrollbar, foreground: "#c6a0f6", background: "#181926")
  end
end

# if ENV["RAILS_ENV"] exists then create a custom prompt
if ENV["RAILS_ENV"]
  IRB.conf[:PROMPT][:RAILS_ENV] = {
    PROMPT_I: "#{ENV["RAILS_ENV"]}> ",
    PROMPT_S: "#{ENV["RAILS_ENV"]}> ",
    PROMPT_C: "#{ENV["RAILS_ENV"]}> ",
    RETURN: "=> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :RAILS_ENV
end
