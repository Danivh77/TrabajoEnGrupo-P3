defmodule MyMusic do

  def iniciar do
    canciones = [
      %{
        id: 1,
        titulo: "Spring Day",
        artista: "BTS",
        genero: "K-pop",
        duracion: 274,
        favorita: true
      },
      %{
        id: 2,
        titulo: "Break Stuff",
        artista: "Limp Bizkit",
        genero: "Nu Metal",
        duracion: 246,
        favorita: false
      },
      %{
        id: 3,
        titulo: "Chop Suey!",
        artista: "System of a Down",
        genero: "Nu Metal",
        duracion: 330,
        favorita: false
      }
    ]

    playlists = [
      %{
        id: 1,
        nombre: "Para Entrenar",
        descripcion: "Canciones para escuchar mientras entreno",
        canciones: [2, 3]
      },
      %{
        id: 2,
        nombre: "Favoritas",
        descripcion: "Mis canciones favoritas",
        canciones: [1]
      }
    ]

    menu(canciones, playlists)
  end

  defp menu(canciones, playlists) do

    """
    ========================================
                  MyMusic
    ========================================
    1. Gestionar canciones
    2. Gestionar playlists
    3. Agregar canción a una playlist
    4. Eliminar canción de una playlist
    5. Ver estadísticas
    6. Salir
    """
    |>Util.mostrar_mensaje()

    opcion = "Seleccione una opción: "
    |> Util.ingresar(:entero)

    case opcion do
      1 ->
        menu_canciones(canciones, playlists)
      2 ->
        menu_playlists(canciones, playlists)
      3 ->
        {nuevas_playlists, msg} = agregar_a_playlist(canciones, playlists)
        Util.mostrar_mensaje(msg)
        menu(canciones, nuevas_playlists)
      4 ->
        {nuevas_playlists, msg} = quitar_de_playlist(playlists)
        Util.mostrar_mensaje(msg)
        menu(canciones, nuevas_playlists)
      5 ->
        ver_estadisticas(canciones, playlists)
        menu(canciones, playlists)
      6 ->
        Util.mostrar_mensaje("¡Gracias por usar MyMusic!")
      _ ->
        Util.mostrar_mensaje("Opción inválida.")
        menu(canciones, playlists)
    end
  end

  # El CRUD de canciones

  def menu_canciones(canciones) do

    Util.mostrar_mensaje("""

    ==============================
              CANCIONES
    ==============================
    1. Crear canción
    2. Ver canciones
    3. Actualizar canción
    4. Eliminar canción
    5. Buscar canción
    6. Volver

    """)

    opcion = Util.ingresar("Seleccione una opción: ", :entero)

    case opcion do
      1 ->
        nuevas_canciones = crear_cancion(canciones)
        menu_canciones(nuevas_canciones)

      2 ->
        mostrar_canciones(canciones)
        menu_canciones(canciones)

      3 ->
        nuevas_canciones = actualizar_cancion(canciones)
        menu_canciones(nuevas_canciones)

      4 ->
        nuevas_canciones = eliminar_cancion(canciones)
        menu_canciones(nuevas_canciones)

      5 ->
        buscar_cancion(canciones)
        menu_canciones(canciones)

      6 ->
        canciones

      _ ->
        Util.mostrar_mensaje("Opción inválida.")
        menu_canciones(canciones)
      end
    end

    # Create - Crear Canción

    def crear_cancion(canciones) do

    Util.mostrar_mensaje("\n===== CREAR CANCIÓN =====")

    titulo = Util.ingresar("Título: ", :texto)
    artista = Util.ingresar("Artista: ", :texto)
    genero = Util.ingresar("Género: ", :texto)
    duracion = Util.ingresar("Duración en segundos: ", :entero)

    respuesta = Util.ingresar("¿Es favorita? (s/n): ", :texto)

    favorita = String.downcase(respuesta) == "s"

    id = siguiente_id(canciones)

    nueva_cancion = %{
      id: id,
      titulo: titulo,
      artista: artista,
      genero: genero,
      duracion: duracion,
      favorita: favorita
    }

    nuevas_canciones = canciones ++ [nueva_cancion]

    Util.mostrar_mensaje("Canción creada correctamente.")

    nuevas_canciones
  end

  # Read - Ver Canciones

  def mostrar_canciones(canciones) do

    Util.mostrar_mensaje("\n===== LISTA DE CANCIONES =====")

    if canciones == [] do
      Util.mostrar_mensaje("No hay canciones registradas.")
    else
      Enum.each(canciones, fn cancion ->
        mostrar_cancion(cancion)
      end)
    end
  end


  def mostrar_cancion(cancion) do

    minutos = div(cancion.duracion, 60)
    segundos = rem(cancion.duracion, 60)

    favorita =
      if cancion.favorita do
        "<3"
      else
        ""
      end

    Util.mostrar_mensaje(
      "#{cancion.id}. #{cancion.titulo} - #{cancion.artista} | " <>
      "#{cancion.genero} | " <>
      "#{minutos}:#{String.pad_leading(to_string(segundos), 2, "0")} #{favorita}"
    )
  end

  # Update - Actualizar Canción

  def actualizar_cancion(canciones) do

    Util.mostrar_mensaje("\n===== ACTUALIZAR CANCIÓN =====")

    mostrar_canciones(canciones)

    id = Util.ingresar("Ingrese el ID de la canción: ", :entero)

    cancion = Enum.find(canciones, fn cancion ->
      cancion.id == id
    end)

    if cancion == nil do

      Util.mostrar_mensaje("No existe una canción con ese ID.")

      canciones

    else

      mostrar_cancion(cancion)

      Util.mostrar_mensaje("""

      ¿Qué desea modificar?

      1. Título
      2. Artista
      3. Género
      4. Duración
      5. Favorita
      """)

      opcion = Util.ingresar("Seleccione: ", :entero)

      nuevas_canciones =
        Enum.map(canciones, fn cancion_actual ->

          if cancion_actual.id == id do

            case opcion do

              1 ->
                nuevo_titulo =
                  Util.ingresar("Nuevo título: ", :texto)

                %{cancion_actual | titulo: nuevo_titulo}

              2 ->
                nuevo_artista =
                  Util.ingresar("Nuevo artista: ", :texto)

                %{cancion_actual | artista: nuevo_artista}

              3 ->
                nuevo_genero =
                  Util.ingresar("Nuevo género: ", :texto)

                %{cancion_actual | genero: nuevo_genero}

              4 ->
                nueva_duracion =
                  Util.ingresar(
                    "Nueva duración en segundos: ",
                    :entero
                  )

                %{cancion_actual | duracion: nueva_duracion}

              5 ->
                respuesta =
                  Util.ingresar(
                    "¿Es favorita? (s/n): ",
                    :texto
                  )

                %{cancion_actual |
                  favorita: String.downcase(respuesta) == "s"
                }

              _ ->
                cancion_actual
            end

          else
            cancion_actual
          end
        end)

      Util.mostrar_mensaje("Canción actualizada.")

      nuevas_canciones
    end
  end

  # Delete - Eliminar Canción

  def eliminar_cancion(canciones) do

    Util.mostrar_mensaje("\n===== ELIMINAR CANCIÓN =====")

    id = Util.ingresar("Ingrese el ID de la canción: ", :entero)

    cancion = Enum.find(canciones, fn cancion ->
      cancion.id == id
    end)

    if cancion == nil do

      Util.mostrar_mensaje("La canción no existe.")

      canciones

    else

      nuevas_canciones =
        Enum.filter(canciones, fn cancion_actual ->
          cancion_actual.id != id
        end)

      Util.mostrar_mensaje(
        "Canción \"#{cancion.titulo}\" eliminada."
      )

      nuevas_canciones
    end
  end

  # Buscar Canción

  def buscar_cancion(canciones) do

    Util.mostrar_mensaje("\n===== BUSCAR CANCIÓN =====")

    texto =
      Util.ingresar(
        "Ingrese título o artista: ",
        :texto
      )
      |> String.downcase()

    resultados =
      Enum.filter(canciones, fn cancion ->

        String.contains?(
          String.downcase(cancion.titulo),
          texto
        ) or

        String.contains?(
          String.downcase(cancion.artista),
          texto
        )

      end)

    if resultados == [] do

      Util.mostrar_mensaje("No se encontraron canciones.")

    else

      Util.mostrar_mensaje("\n Resultados:")

      Enum.each(resultados, fn cancion ->
        mostrar_cancion(cancion)
      end)

    end
  end




end

MyMusic.iniciar()
