#
# File     : auth_controller.ex
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
defmodule Diskusi.AuthController do
  @moduledoc """
  Auth-related actions controller.
  """

  use Diskusi.Web, :controller

  alias Diskusi.AuthView
  alias Diskusi.Repo
  alias Diskusi.User

  # Use static page layout
  plug :put_layout, "static.html"

  # Scrub empty inputs from the form data
  plug :scrub_params, "email" when action in [:process_login]
  plug :scrub_params, "password" when action in [:process_login]

  @doc """
  GET /register
  """
  def register(conn, _params) do
    conn |> render("register.html")
  end

  @doc """
  GET /login
  """
  def login(conn, _params) do
    conn |> render("login.html")
  end

  @doc """
  POST /login
  """
  def process_login(conn, %{"email" => email, "password" => password}) do
    if user = Repo.get_by(User, %{email: email, password: password}) do
      conn
      |> Guardian.Plug.sign_in(user, :token)
      |> redirect(to: home_path(conn, :index))
    else
      conn |> render("login.html")
    end
  end

  @doc """
  GET /logout
  """
  def logout(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> put_flash(:info, "Logged out")
    |> redirect(to: auth_path(conn, :login))
  end

  @doc """
  Internal controller method called from unauthenticated sessions
  prompting User to login.
  """
  def unauthenticated_session(conn, _params) do
    # Use specific to support Guardian's `EnsureAuthenticated` plug
    # See: https://github.com/ueberauth/guardian/issues/37
    conn
    |> put_flash(:info, "You need to be logged in to view the page")
    |> put_view(AuthView)
    |> put_status(:unauthorized)
    |> render("login.html")
  end

end