# app/services/chat/answer_question.rb

module Chat
  class AnswerQuestion
    def self.call(question)
      new(question).call
    end

    def initialize(question)
      @question = normalize(question)

      @profile = Profile.includes(
        :experiences,
        :skills,
        :certifications,
        :educations,
        :languages,
        :achievements,
        :recommendations
      ).first
    end

    def call
      return profile_not_found unless @profile

      case intent
      when :why_hire
        why_hire

      when :career
        career_summary

      when :ruby
        ruby_experience

      when :technical_leadership
        technical_leadership

      when :pmo
        pmo_experience

      when :financial
        financial_experience

      when :projects
        projects

      when :skills
        skills

      when :certifications
        certifications

      when :education
        education

      when :languages
        languages

      when :achievements
        achievements

      when :recommendation
        recommendation

      else
        default_answer
      end
    end

    private

    # ------------------------------------------------------------
    # Intent detection
    # ------------------------------------------------------------

    def intent
      return :why_hire if matches?(
        "contratar",
        "por que contratar",
        "porque contratar",
        "valor aporta",
        "valor puedes aportar",
        "valor aporta arantzazu",
        "que aporta",
        "que puede aportar",
        "por que elegir",
        "por que deberia contratar"
      )

      return :technical_leadership if matches?(
        "technical lead",
        "tech lead",
        "lider tecnico",
        "liderazgo tecnico",
        "liderazgo",
        "liderar equipos",
        "liderar equipo",
        "coordinar equipo",
        "mentoring",
        "mentor",
        "code review",
        "code reviews"
      )

      return :pmo if matches?(
        "pmo",
        "project management",
        "project manager",
        "delivery manager",
        "delivery",
        "gestion de proyectos",
        "gestionar proyectos",
        "planificacion",
        "capacity planning",
        "riesgos",
        "dependencias",
        "kpi",
        "reporting"
      )

      return :financial if matches?(
        "financiero",
        "financiera",
        "banca",
        "bancario",
        "bancaria",
        "banking",
        "caja rural",
        "sector financiero"
      )

      return :ruby if matches?(
        "ruby",
        "rails",
        "ruby on rails",
        "backend",
        "api rest",
        "rest api",
        "postgresql",
        "redis",
        "sidekiq"
      )

      return :skills if matches?(
        "skill",
        "skills",
        "habilidades",
        "tecnologias",
        "tecnologia",
        "stack",
        "conocimientos",
        "competencias"
      )

      return :certifications if matches?(
        "certificacion",
        "certificaciones",
        "certificado",
        "certificados"
      )

      return :education if matches?(
        "educacion",
        "estudios",
        "formacion",
        "master",
        "maestria",
        "ingenieria",
        "universidad",
        "grado"
      )

      return :languages if matches?(
        "idioma",
        "idiomas",
        "ingles",
        "frances",
        "portugues",
        "italiano"
      )

      return :achievements if matches?(
        "logro",
        "logros",
        "achievement",
        "achievements",
        "exito",
        "resultados"
      )

      return :recommendation if matches?(
        "recomendacion",
        "recomendaciones",
        "referencia",
        "referencias",
        "que dicen de ti",
        "que opinan de ti"
      )

      return :projects if matches?(
        "proyecto",
        "proyectos",
        "responsabilidades",
        "que ha gestionado",
        "que has gestionado",
        "que gestionas"
      )

      return :career if matches?(
        "experiencia",
        "trayectoria",
        "carrera",
        "evolucion",
        "perfil",
        "sobre ti",
        "sobre arantzazu",
        "quien es arantzazu"
      )

      :unknown
    end

    # ------------------------------------------------------------
    # Answers
    # ------------------------------------------------------------

    def why_hire
      <<~TEXT
        Arantzazu aporta una combinación poco habitual de experiencia
        técnica, liderazgo y visión de delivery.

        Tiene más de 7 años de experiencia en desarrollo de software,
        con una especialización especialmente sólida en Ruby on Rails y
        backend, incluyendo más de seis años trabajando en aplicaciones
        críticas del sector financiero.

        Su trayectoria ha evolucionado desde Software Engineer hacia
        Senior Ruby on Rails Engineer, Technical Lead y posteriormente
        PMO en Operations.

        Esto le permite entender un proyecto desde varias perspectivas:

        • Ingeniería y arquitectura.
        • Desarrollo backend y APIs.
        • Calidad, rendimiento y mantenibilidad.
        • Liderazgo técnico y mentoring.
        • Planificación y coordinación.
        • Capacity planning.
        • Riesgos y dependencias.
        • KPIs y reporting ejecutivo.
        • Comunicación entre equipos técnicos y negocio.

        Su principal valor diferencial es precisamente esa capacidad para
        conectar Engineering, Delivery y Business.

        Es especialmente interesante para organizaciones que necesitan
        una persona capaz de entender la tecnología en profundidad y,
        al mismo tiempo, participar en decisiones de coordinación,
        planificación y negocio.
      TEXT
    end

    def career_summary
      experiences = @profile.experiences.order(start_date: :asc)

      lines = experiences.map do |experience|
        "#{experience.start_date.year} — #{experience.position}"
      end

      <<~TEXT
        La trayectoria de Arantzazu muestra una evolución progresiva desde
        el desarrollo de software hacia posiciones de mayor responsabilidad
        técnica y organizativa.

        #{lines.join("\n")}

        Su recorrido puede resumirse en cuatro etapas:

        1. Software Engineering
           Desarrollo de software y participación en proyectos técnicos.

        2. Senior Ruby on Rails Engineering
           Especialización en backend, APIs, bases de datos, rendimiento
           y aplicaciones críticas.

        3. Technical Leadership
           Diseño técnico, code reviews, coordinación, mentoring,
           planificación y colaboración con Product y negocio.

        4. PMO / Delivery
           Planificación, governance, capacity planning, riesgos,
           dependencias, KPIs y reporting ejecutivo.

        Actualmente combina una sólida base de ingeniería con una visión
        transversal de tecnología, proyectos y negocio.
      TEXT
    end

    def ruby_experience
      experience = find_experience(/ruby|rails/i)

      return "No hay información específica sobre Ruby on Rails en el CV." unless experience

      <<~TEXT
        Arantzazu tiene más de 7 años de experiencia profesional en
        desarrollo de software y una especialización especialmente sólida
        en Ruby on Rails.

        Su experiencia principal en Ruby on Rails se desarrolló en el
        sector financiero, trabajando en aplicaciones bancarias críticas
        como Senior Ruby on Rails Engineer y Technical Lead.

        Entre sus responsabilidades estuvieron:

        • Desarrollo y evolución de funcionalidades.
        • Diseño y consumo de APIs REST.
        • Optimización de rendimiento y SQL.
        • Refactorización aplicando SOLID y Clean Code.
        • Resolución de incidencias en producción.
        • Integraciones con servicios externos.
        • Diseño de soluciones técnicas.
        • Code reviews.
        • Mentoring.
        • Coordinación técnica.
        • CI/CD y despliegues.

        Su stack relacionado incluye Ruby, Ruby on Rails, PostgreSQL,
        MySQL, Redis, Docker, AWS, Jenkins, Git y Capistrano.
      TEXT
    end

    def technical_leadership
      <<~TEXT
        Sí. Arantzazu tiene experiencia desempeñando funciones de
        Technical Lead durante su etapa como Senior Ruby on Rails Engineer.

        Su liderazgo técnico incluía:

        • Diseño de soluciones.
        • Toma de decisiones técnicas.
        • Code reviews.
        • Coordinación del equipo.
        • Planificación y seguimiento de sprints.
        • Priorización y asignación de tareas.
        • Estimación.
        • Mentoring de desarrolladores.
        • Documentación técnica.
        • Colaboración con Product Owners.
        • Colaboración con Functional Analysts.

        Lo destacable es que su liderazgo no parte únicamente de una
        perspectiva de gestión: está respaldado por experiencia real
        desarrollando software y trabajando con sistemas críticos.
      TEXT
    end

    def pmo_experience
      <<~TEXT
        Desde marzo de 2026, Arantzazu desarrolla funciones de PMO dentro
        del área de Operations de knowmad mood.

        Su experiencia incluye:

        • Planificación y seguimiento de proyectos.
        • Capacity planning.
        • Gestión de riesgos.
        • Gestión de dependencias y bloqueos.
        • Seguimiento de KPIs.
        • Executive reporting.
        • Delivery governance.
        • Seguimiento de incidentes críticos.
        • Coordinación entre Development, Operations y Business.
        • Mejora continua.
        • Transformación organizativa.

        Esta experiencia complementa su trayectoria como ingeniera y
        Technical Lead, aportándole una visión más amplia de delivery,
        operaciones y negocio.
      TEXT
    end

    def financial_experience
      <<~TEXT
        Sí. Arantzazu cuenta con más de seis años de experiencia
        desarrollando y manteniendo aplicaciones críticas del sector
        financiero.

        Su principal experiencia corresponde a proyectos para Caja Rural
        RSI, donde trabajó como Senior Ruby on Rails Engineer y Technical
        Lead entre junio de 2020 y febrero de 2026.

        Durante esta etapa trabajó con:

        • Aplicaciones bancarias críticas.
        • APIs REST.
        • Bases de datos.
        • Optimización de rendimiento.
        • Integraciones externas.
        • Incidencias de producción.
        • Despliegues y CI/CD.
        • Coordinación técnica.

        Esta experiencia aporta además conocimiento de entornos donde la
        estabilidad, mantenibilidad y calidad del software son especialmente
        importantes.
      TEXT
    end

    def projects
      projects = @profile.projects

      if projects.any?
        return projects.map do |project|
          "• #{project.name}"
        end.join("\n")
      end

      @profile.experiences.map do |experience|
        <<~TEXT
          #{experience.position}
          #{experience.description}
        TEXT
      end.join("\n")
    end

    def skills
      grouped = @profile.skills.group_by(&:category)

      grouped.map do |category, category_skills|
        names = category_skills.map(&:name).join(", ")

        "#{category}\n#{names}"
      end.join("\n\n")
    end

    def certifications
      certifications = @profile.certifications.order(year: :desc)

      certifications.map do |certification|
        year = certification.year ? " (#{certification.year})" : ""

        "• #{certification.name}#{year}"
      end.join("\n")
    end

    def education
      @profile.educations.map do |item|
        end_year = item.end_year || "actualidad"

        "• #{item.degree} — #{item.institution} " \
          "(#{item.start_year}–#{end_year})"
      end.join("\n")
    end

    def languages
      @profile.languages.map do |language|
        "• #{language.name}: #{language.level}"
      end.join("\n")
    end

    def achievements
      @profile.achievements.map do |achievement|
        "• #{achievement.description}"
      end.join("\n")
    end

    def recommendation
      recommendation = @profile.recommendations.order(date: :desc).first

      return "Actualmente no hay recomendaciones disponibles." unless recommendation

      <<~TEXT
        Una recomendación de Fátima Zel-lal Prieto, Head of People en
        knowmad mood, destaca especialmente la evolución profesional
        de Arantzazu.

        La recomendación pone en valor su adaptabilidad, compromiso,
        capacidad de trabajo en equipo y evolución desde un perfil
        técnico hacia una perspectiva más global de tecnología,
        proyectos y negocio.

        También destaca su participación en proyectos para Autovidal
        y Caja Rural RSI, así como su colaboración en actividades
        relacionadas con Delivery y revisión de propuestas
        comerciales y técnicas.
      TEXT
    end

    def default_answer
      <<~TEXT
        Puedo ayudarte a conocer mejor el perfil profesional de Arantzazu.

        Puedes preguntarme, por ejemplo:

        • ¿Por qué debería contratar a Arantzazu?
        • ¿Cuál ha sido su evolución profesional?
        • ¿Qué experiencia tiene con Ruby on Rails?
        • ¿Ha trabajado en el sector financiero?
        • ¿Qué experiencia tiene como Technical Lead?
        • ¿Qué puede aportar como PMO?
        • ¿Cuál es su stack tecnológico?
        • ¿Qué proyectos ha gestionado?
        • ¿Qué certificaciones tiene?
        • ¿Qué formación tiene?
        • ¿Qué idiomas habla?
        • ¿Qué logros profesionales tiene?
      TEXT
    end

    def profile_not_found
      "No hay información de perfil disponible en este momento."
    end

    # ------------------------------------------------------------
    # Helpers
    # ------------------------------------------------------------

    def find_experience(pattern)
      @profile.experiences.find do |experience|
        experience.position.to_s.match?(pattern) ||
          experience.description.to_s.match?(pattern)
      end
    end

    def matches?(*terms)
      terms.any? { |term| @question.include?(normalize(term)) }
    end

    def normalize(text)
      text
        .to_s
        .downcase
        .unicode_normalize(:nfkd)
        .gsub(/\p{Mn}/, "")
        .strip
    end
  end
end