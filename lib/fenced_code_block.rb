class FencedCodeBlock < Nanoc::Filter
  identifier :fenced_code_block

  def run(content, params={})
    content.gsub(/(^`{3}\s*(\S*)\s*$([^`]*)^`{3}\s*$)+?/m) {|match|
      lang_spec  = $2
      code_block = $3.lstrip

      css_class = lang_spec.empty? ? 'language-none' : 'language-' + lang_spec
      replacement = '<pre class="' + css_class + '"><code class="' + css_class + '">' + code_block
      replacement << '</code></pre>'
    }
  end
end
