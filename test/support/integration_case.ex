#
# File     : integration_case.ex
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
defmodule Diskusi.IntegrationCase do
  @moduledoc """
  Integration test case fixtures.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      # Reverse routing support
      import Diskusi.Router.Helpers

      alias Diskusi.Repo
      alias Diskusi.User

      # The default endpoint for testing
      @endpoint Diskusi.Endpoint

      # FIXME: Duplicate function in `conn_case.ex`, unable to extract to a separate module as it's throwing `RuntimeError`
      # Guardian login helper functions
      # ~~~~
      # We need a way to get into the connection to login a user
      # We need to use the `bypass_through` to fire the plugs in the router
      # and get the session fetched.
      #
      # Example:
      #   conn =
      #     conn
      #     |> guardian_login(user)
      #     |> get(home_path(conn, :index))
      #
      def guardian_login(%User{} = user), do: guardian_login(conn(), user, :token, [])
      def guardian_login(%User{} = user, token), do: guardian_login(conn(), user, token, [])
      def guardian_login(%User{} = user, token, opts), do: guardian_login(conn(), user, token, opts)

      def guardian_login(%Plug.Conn{} = conn, user), do: guardian_login(conn, user, :token, [])
      def guardian_login(%Plug.Conn{} = conn, user, token), do: guardian_login(conn, user, token, [])
      def guardian_login(%Plug.Conn{} = conn, user, token, opts) do
        conn
          |> bypass_through(Diskusi.Router, [:browser])
          |> get("/")
          |> Guardian.Plug.sign_in(user, token, opts)
          |> send_resp(200, "Flush the session")
          |> recycle()
      end
    end
  end

  setup do
    {:ok, conn: Phoenix.ConnTest.conn()}
  end

end