 defmodule Util do
  def mostrar_mensaje(mensaje) do
    IO.puts(mensaje)
  end

  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  def ingresar(mensaje, :entero) do
    try do
      mensaje
      |> IO.gets()
      |> String.trim()
      |> String.to_integer()
    rescue
      ArgumentError ->
        IO.puts("Error: Debe ingresar un número entero válido. Intente de nuevo.")
        ingresar(mensaje, :entero)
    end
  end

  def ingresar(mensaje, :flotante) do
    try do
      mensaje
      |> IO.gets()
      |> String.trim()
      |> String.to_float()
    rescue
      ArgumentError ->
        IO.puts("Error: Debe ingresar un número flotante válido. Intente de nuevo.")
        ingresar(mensaje, :flotante)
    end
  end

end
