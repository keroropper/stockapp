module MarkDownHelper
  def markdown(content) #括弧内はカラム名
    options = {
      filter_html:     true,     # htmlを出力しない
      hard_wrap:       true,     # マークダウン中の空行をhtmlに置き換え
      space_after_headers: true, # # と文字の間にスペースを要求
      with_toc_data: true
    }
    
    extensions = {
      autolink:           true,  # <>で囲まれてなくてもリンクを認識
      no_intra_emphasis:  true,  # 単語中の強調を認識しない
      fenced_code_blocks: true,  # フェンスのあるコードブロックを認識
      strikethrough:      true,  # ~ 2つで取り消し線
      superscript:        true,  # ^ の後ろが上付き文字
      tables:             true,  # テーブルを認識
      underline:          true,  # 斜線(* *)
      highlight:          true,  # ハイライト(== ==)
      quote:              true,  # 引用符(" ")
      footnotes:          true,  # 脚注( ^[1] )
    }
    
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(content).html_safe
  end
end