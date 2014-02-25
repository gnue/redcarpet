# coding: UTF-8
require 'test_helper'

class DendenTest < Test::Unit::TestCase

  def setup
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def render_with(flags, text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, flags).render(text)
  end

  def test_page_break
    rd = render_with({:page_break => true}, "===\n")
    assert rd =~ %r[<div class="docbreak"></div>]
  end

  def test_group_ruby
    rd = render_with({:ruby => true}, "{電子出版|でんししゅっぱん}を手軽に\n")
    assert rd =~ %r[<p><ruby>電子出版<rt>でんししゅっぱん</rt></ruby>を手軽に</p>]
  end

  def test_mono_ruby
    rd = render_with({:ruby => true}, "{電子出版|でん|し|しゅっ|ぱん}を手軽に\n")
    assert rd =~ %r[<p><ruby>電<rt>でん</rt>子<rt>し</rt>出<rt>しゅっ</rt>版<rt>ぱん</rt></ruby>を手軽に</p>]
  end

  def test_tcy
    rd = render_with({:tcy => true}, "昭和^53^年\n")
    assert rd =~ %r[<p>昭和<span class="tcy">53</span>年</p>]
  end
end
