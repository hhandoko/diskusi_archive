#
# File     : auth_controller_test.exs
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
defmodule Diskusi.AuthControllerTest do
  use Diskusi.ConnCase, async: true

  # Login tests
  # ~~~~
  test "`GET /register` should render registration page", %{conn: conn} do
    conn = get conn, auth_path(conn, :register)
    assert html_response(conn, 200) =~ "Register"
  end

  test "`GET /login` should render page", %{conn: conn} do
    conn = get conn, auth_path(conn, :login)
    assert html_response(conn, 200) =~ "Login"
  end

  test "`POST /login` should return to login page when given invalid credentials", %{conn: conn} do
    conn = post conn, auth_path(conn, :process_login), %{email: "notjoe@bloggs.com", password: "jb"}
    assert html_response(conn, 200) =~ "Login"
  end

  test "`POST /login` should redirect to the User homepage when given correct credentials", %{conn: conn} do
    conn = post conn, auth_path(conn, :process_login), %{email: "joe@bloggs.com", password: "jb"}
    assert redirected_to(conn) == home_path(conn, :index)
  end

end