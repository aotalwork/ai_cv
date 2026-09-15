module Chat
  class AnswerQuestion
    def self.call(question)
      new(question).call
    end

    def initialize(question)
      @question = question.to_s.strip
      @profile = Profile.includes(
        :experiences,
        :projects,
        :skills,
        :certifications,
        :educations,
        :languages,
        :achievements,
        :recommendations
      ).first
    end

    def call
      return default_answer if @profile.nil?
      return default_answer if @question.blank?

      question = normalize(@question)

      # ------------------------------------------------------------
      # PERSONAS / VIDA PERSONAL
      # ------------------------------------------------------------

      # Trotsky tiene prioridad para evitar que "perro" o "mascota"
      # termine en otra respuesta.
      return trotsky if question.match?(/\btrotsky\b/)

      case question

      when /quien es|presenta|presentacion|sobre arantzazu|sobre ella/
        personal_introduction

      when /perro|perros|mascota|mascotas/
        trotsky

      when /tiempo libre|ocio|aficiones|aficion|hobbies|hobby/
        hobbies

      when /musica|canciones|grupo favorito|grupos favoritos/
        music

      when /viajar|viajes|kenia|kenya|china/
        travel

      when /deporte|deportes|gimnasio|nadar|natacion|kayak|snorkel|paddle|buceo/
        sports

      when /cadiz|jerez|naturaleza|montana|playa/
        cadiz_and_nature

      when /cocina|cocinar|manualidades|madera|carpinteria|ceramica|pintura|3d/
        creative_interests

      when /personalidad|como es|como describirias|como la describirias|fortalezas|fortaleza/
        personality

      when /valores|que valora|importante para ella|importante para arantzazu/
        values

      when /como trabaja|forma de trabajar|trabajando|trabajo en equipo|equipo|metodologia/
        work_style

        # ------------------------------------------------------------
        # PROFESIONAL
        # ------------------------------------------------------------

      when /ruby|rails|backend|back end|desarrollo|programacion/
        technical_experience

      when /technical lead|liderazgo tecnico|lider tecnico|liderar|mentoring|mentoria/
        leadership

      when /pmo|gestion de proyectos|project management|organizacion|planificacion/
        project_management

      when /sector financiero|banca|financiero|caja rural|rsi/
        financial_experience

      when /experiencia|trayectoria|carrera profesional|carrera/
        professional_career

      when /estudios|educacion|universidad|master|grado/
        education

      when /certificacion|certificaciones|cursos|formacion/
        certifications

      when /idioma|idiomas|ingles|frances|portugues|italiano/
        languages

        # ------------------------------------------------------------
        # IA / FUTURO
        # ------------------------------------------------------------

      when /inteligencia artificial|ia|artificial intelligence/
        artificial_intelligence

      when /futuro|objetivo|objetivos|ambiciones|ambicion|sueno|suenos/
        future_goals

      when /videojuego|videojuegos|game/
        videogame

      else
        general_answer
      end
    end

    private

    # ------------------------------------------------------------
    # NORMALIZACIÓN
    # ------------------------------------------------------------

    def normalize(text)
      text
        .to_s
        .downcase
        .unicode_normalize(:nfkd)
        .encode("ASCII", replace: "")
        .gsub(/[¿?¡!.,;:]/, " ")
        .squeeze(" ")
        .strip
    end

    # ------------------------------------------------------------
    # PERFIL
    # ------------------------------------------------------------

    def personal_introduction
      <<~TEXT.strip
        Arantzazu Otal Alberro es Senior Ruby on Rails Engineer, Technical Lead y actualmente PMO en el área de Operations de knowmad mood.

        Su trayectoria combina desarrollo de software, liderazgo técnico y gestión de proyectos. Ha trabajado durante más de seis años en aplicaciones críticas del sector financiero y ha evolucionado desde Software Engineer hasta asumir responsabilidades de Technical Lead y PMO.

        Es una profesional organizada, responsable, curiosa y orientada a la mejora continua. Le gusta entender los problemas, investigar, buscar soluciones y conectar la parte técnica con las necesidades del negocio.

        Fuera del trabajo disfruta especialmente de los animales, la naturaleza, la música, los viajes, el deporte y aprender cosas nuevas.
      TEXT
    end

    # ------------------------------------------------------------
    # TECNOLOGÍA
    # ------------------------------------------------------------

    def technical_experience
      <<~TEXT.strip
        Arantzazu tiene una sólida experiencia en desarrollo backend, especialmente con Ruby on Rails.

        Durante su etapa como Senior Ruby on Rails Engineer y Technical Lead trabajó con Ruby, Ruby on Rails, PostgreSQL, MySQL, Redis, Docker, AWS, Jenkins, Git y Capistrano.

        Su experiencia incluye desarrollo de nuevas funcionalidades, APIs REST, optimización de consultas SQL y rendimiento, resolución de incidencias en producción, integraciones externas, diseño técnico, revisiones de código, CI/CD y despliegues.

        También presta especial atención a principios como SOLID, Clean Code, mantenibilidad y calidad del software.
      TEXT
    end

    def leadership
      <<~TEXT.strip
        Como Technical Lead, Arantzazu combinó el trabajo técnico con la coordinación de equipos.

        Entre sus responsabilidades estuvieron la planificación de sprints, seguimiento del trabajo, priorización y asignación de tareas, estimaciones, revisiones de código, mentoring y coordinación técnica.

        También trabajó de forma cercana con Product Owners y Functional Analysts para transformar necesidades funcionales en soluciones técnicas.

        Para ella, el liderazgo también implica compartir conocimiento, ayudar al equipo y facilitar que las personas puedan trabajar mejor.
      TEXT
    end

    def project_management
      <<~TEXT.strip
        Desde marzo de 2026 trabaja como PMO en el área de Operations de knowmad mood.

        Su trabajo incluye planificación y seguimiento de proyectos, gestión de riesgos, dependencias y bloqueos, capacity planning, seguimiento de KPIs, reporting ejecutivo y coordinación entre Development, Operations y Business.

        También participa en la gestión de incidentes críticos, mejora de procesos y gobernanza de la entrega.

        Esta experiencia le ha permitido ampliar su perspectiva y entender la relación entre tecnología, proyectos, operaciones y negocio.
      TEXT
    end

    def financial_experience
      <<~TEXT.strip
        Una parte muy importante de la trayectoria de Arantzazu está relacionada con el sector financiero.

        Trabajó durante más de cinco años con Caja Rural RSI desarrollando y manteniendo aplicaciones críticas.

        Participó en nuevas funcionalidades, APIs, integraciones, optimización, incidencias de producción, diseño técnico, revisiones de código y despliegues.

        Esta experiencia le ha permitido trabajar en entornos donde la calidad, estabilidad y responsabilidad técnica son especialmente importantes.
      TEXT
    end

    def professional_career
      <<~TEXT.strip
        La trayectoria profesional de Arantzazu ha evolucionado progresivamente:

        • Software Engineer en la Universidad de Cádiz.
        • Software Engineer en knowmad mood para Autovidal.
        • Senior Ruby on Rails Engineer y Technical Lead para Caja Rural RSI.
        • Actualmente PMO en Operations en knowmad mood.

        Su evolución combina experiencia técnica, liderazgo y gestión, manteniendo siempre el interés por seguir aprendiendo y trabajando con tecnología.
      TEXT
    end

    # ------------------------------------------------------------
    # FORMACIÓN
    # ------------------------------------------------------------

    def education
      educations = @profile.educations

      return "Su formación principal es en Ingeniería Informática y actualmente continúa especializándose en Inteligencia Artificial." if educations.empty?

      educations.map do |education|
        period = [education.start_year, education.end_year].compact.join(" - ")

        result = "#{education.degree} — #{education.institution}"

        result += " (#{period})" if period.present?

        result
      end.join("\n")
    end

    def certifications
      certifications = @profile.certifications

      return "Cuenta con formación en Agile, Scrum, ITIL, AWS, Atlassian, IA y desarrollo profesional." if certifications.empty?

      names = certifications.map(&:name).compact

      <<~TEXT.strip
        Cuenta con formación y certificaciones en diferentes áreas, entre ellas:

        #{names.map { |name| "• #{name}" }.join("\n")}
      TEXT
    end

    def languages
      languages = @profile.languages

      return "Español nativo e inglés B2, además de conocimientos de francés, portugués e italiano." if languages.empty?

      languages.map do |language|
        "#{language.name}: #{language.level}"
      end.join("\n")
    end

    # ------------------------------------------------------------
    # PERSONALIDAD
    # ------------------------------------------------------------

    def personality
      <<~TEXT.strip
        Arantzazu se considera una persona curiosa, versátil, responsable y con muchas ganas de aprender.

        Personalmente es más introvertida, mientras que en el entorno laboral puede adoptar un papel mucho más extrovertido cuando necesita colaborar, coordinar o ayudar a otras personas.

        Le gusta crear cosas nuevas, resolver problemas y comprender diferentes áreas en lugar de limitarse a una única especialidad.

        También le gustaría que las personas la describieran como alguien de buen corazón, generosa y paciente.
      TEXT
    end

    def work_style
      <<~TEXT.strip
        Arantzazu suele investigar primero por su cuenta antes de preguntar.

        Le gusta consultar documentación, probar soluciones y entender el problema. Si no encuentra la respuesta, pregunta y utiliza el debate para contrastar ideas.

        Se considera una persona decisiva, organizada y responsable.

        También disfruta trabajando en equipo, haciendo mentoring y buscando formas de facilitar el trabajo a los demás.

        Para ella, la calidad significa entregar un trabajo bien probado y sin errores importantes.
      TEXT
    end

    def values
      <<~TEXT.strip
        Arantzazu valora especialmente la empatía, la amabilidad, la generosidad, la responsabilidad y el trabajo bien hecho.

        Le importa la capacidad de ponerse en el lugar de otras personas y aprecia mucho la alegría y la actitud positiva que alguien puede transmitir.

        También rechaza especialmente el comportamiento egoísta cuando perjudica a otras personas y la falta de sinceridad.
      TEXT
    end

    # ------------------------------------------------------------
    # TROTSKY
    # ------------------------------------------------------------

    def trotsky
      <<~TEXT.strip
        Trotsky es el perro de Arantzazu y forma una parte importante de su vida.

        Es un Podenco Portugués de un año.

        A Arantzazu le encantan los perros y disfruta mucho de salir a caminar con Trotsky, especialmente por la naturaleza, la montaña y la playa.

        Compartir tiempo con él encaja perfectamente con una de sus grandes aficiones: disfrutar de los animales y de la naturaleza.
      TEXT
    end

    # ------------------------------------------------------------
    # AFICIONES
    # ------------------------------------------------------------

    def hobbies
      <<~TEXT.strip
        Fuera del trabajo, Arantzazu tiene muchos intereses.

        Le gusta caminar por la naturaleza, especialmente junto a su pareja y Trotsky, disfrutar de la playa, entrenar en el gimnasio y nadar.

        También disfruta de la música, los conciertos, el karaoke, las reuniones con amigos, los juegos de mesa, cocinar, ver películas y series y leer, especialmente fantasía y romance.

        Además, tiene una faceta creativa y práctica: le gusta pintar y le interesan actividades como el diseño 3D, la carpintería y la cerámica.
      TEXT
    end

    def cadiz_and_nature
      <<~TEXT.strip
        Arantzazu vive en la provincia de Cádiz y tiene un vínculo especial con la zona.

        Le gusta Jerez porque considera que tiene un tamaño cómodo y permite tener cerca tanto la montaña como el mar.

        Disfruta especialmente de caminar por la naturaleza y de actividades relacionadas con el mar como snorkel, kayak y paddle surf.

        Uno de sus sueños es tener una casa con jardín, rodeada de naturaleza y, si fuera posible, con terreno para disfrutar del campo durante los fines de semana.
      TEXT
    end

    def sports
      <<~TEXT.strip
        El deporte es una parte importante de su tiempo libre.

        Entrena en el gimnasio y también nada. El entrenamiento le ayuda a relajarse y a sentirse bien.

        Además, disfruta de actividades relacionadas con el mar como snorkel, kayak y paddle surf.

        Le gustaría hacer también un bautismo de buceo.
      TEXT
    end

    def music
      <<~TEXT.strip
        Sus gustos musicales son bastante variados.

        Le gustan especialmente el rock, el reggae, la música de los 80 y 90 y el indie.

        Entre los artistas que disfruta están Pink Floyd, Led Zeppelin, Bob Marley, U2, Oasis, Lana Del Rey y Phil Collins.

        Pink Floyd tiene un significado especial para ella porque los escuchaba con su padre cuando era pequeña durante los viajes en coche.
      TEXT
    end

    def travel
      <<~TEXT.strip
        A Arantzazu le encanta viajar y descubrir lugares nuevos.

        Entre los destinos con los que sueña están Kenia y China.

        Le interesa especialmente conocer lugares diferentes, descubrir nuevas culturas y salir de la rutina.
      TEXT
    end

    def creative_interests
      <<~TEXT.strip
        Tiene una faceta muy creativa y práctica.

        Le gusta pintar y le gustaría aprender diseño 3D, carpintería y cerámica.

        También le atrae mucho crear cosas con sus propias manos.

        Si hubiera elegido una formación diferente a Ingeniería Informática, también le habrían interesado áreas como la arqueología o las Bellas Artes.
      TEXT
    end

    # ------------------------------------------------------------
    # IA Y FUTURO
    # ------------------------------------------------------------

    def artificial_intelligence
      <<~TEXT.strip
        La Inteligencia Artificial es una de las áreas que más le interesa actualmente.

        Está estudiando un Máster en Inteligencia Artificial y quiere seguir desarrollándose profesionalmente en la combinación de IA y software.

        Le interesa especialmente crear sistemas de IA que produzcan resultados útiles y puedan ayudar a las personas, tanto en problemas cotidianos como en ámbitos de mayor impacto.

        Su objetivo es seguir manteniendo una mentalidad técnica y continuar aprendiendo.
      TEXT
    end

    def future_goals
      <<~TEXT.strip
        Profesionalmente quiere seguir trabajando en remoto dentro del mundo del software y especializarse cada vez más en Inteligencia Artificial y desarrollo.

        También quiere mantener la experiencia adquirida en liderazgo y gestión, sin perder su curiosidad técnica.

        En el ámbito personal sueña con viajar, disfrutar de su familia y amigos, tener una casa con jardín y naturaleza y seguir aprendiendo cosas nuevas.

        También le gustaría desarrollar proyectos creativos y tecnológicos propios.
      TEXT
    end

    def videogame
      <<~TEXT.strip
        Uno de sus proyectos soñados es crear un videojuego.

        Le atrae la posibilidad de combinar tecnología, creatividad y narrativa para construir algo propio.

        También encaja con su personalidad curiosa y con su interés por aprender disciplinas diferentes.
      TEXT
    end

    # ------------------------------------------------------------
    # FALLBACK
    # ------------------------------------------------------------

    def general_answer
      <<~TEXT.strip
        Puedo hablar sobre Arantzazu tanto desde el punto de vista profesional como personal.

        Por ejemplo, puedes preguntarme sobre:

        • Su experiencia con Ruby on Rails.
        • Su etapa como Technical Lead.
        • Su trabajo actual como PMO.
        • Su experiencia en el sector financiero.
        • Su formación e Inteligencia Artificial.
        • Su forma de trabajar y sus valores.
        • Sus aficiones, música, viajes y deporte.
        • Trotsky, su perro.
        • Sus objetivos y proyectos de futuro.
      TEXT
    end

    def default_answer
      "No encuentro información suficiente sobre el perfil en este momento."
    end
  end
end