#
# File     : error_view_test.exs
# License  :
#   The MIT License (MIT)
#
#   Copyright (c) 2016 Herdy Handoko
#
#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to deal
#   in the Software without restriction, including without limitation the rights
#   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included in
#   all copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#   THE SOFTWARE.
#
defmodule Diskusi.ErrorViewTest do
  use Diskusi.ConnCase, async: true

  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(Diskusi.ErrorView, "404.html", []) == "Page not found"
  end

  test "render 500.html" do
    assert render_to_string(Diskusi.ErrorView, "500.html", []) == "Server internal error"
  end

  test "render any other" do
    assert render_to_string(Diskusi.ErrorView, "505.html", []) == "Server internal error"
  end
end
