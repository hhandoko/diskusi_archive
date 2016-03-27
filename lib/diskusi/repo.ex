#
# File     : repo.ex
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
defmodule Diskusi.Repo do
  @moduledoc """
  In-memory repository.
  """

  @doc """
  Returns the list of all Users.

  ## Parameters
    - Diskusi.User: User to retrieve
  """
  def all(Diskusi.User) do
    [%Diskusi.User{id: "1", name: "Joe Bloggs", username: "joebloggs", email: "joe@bloggs.com", password: "jb"}]
  end

  @doc """
  Returns an empty list for unknown model repositories.

  ## Parameters
    - module: Model repository module.
  """
  def all(_module), do: []

  @doc """
  Return models matching the ID.

  ## Parameters
    - module: Model repository module.
    - id: Model ID.
  """
  def get(module, id) do
    Enum.find all(module), fn map -> map.id == id end
  end

  @doc """
  Return models matching the given params.

  ## Parameters
    - module: Model repository module.
    - params: Model parameter key-value.
  """
  def get_by(module, params) do
    Enum.find all(module), fn map ->
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end

  #use Ecto.Repo, otp_app: :diskusi
end
