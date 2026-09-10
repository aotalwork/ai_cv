module Chat
  class AnswerQuestion
    def self.call(question)
      new(question).call
    end

    def initialize(question)
      @question = question.downcase.strip

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
      case @question
      when /ruby|rails/
        ruby_experience

      when /technical lead|liderazgo|lider/
        technical_lead

      when /pmo|project management|gestión de proyectos/
        pmo_experience

      when /financiero|banca|bancario/
        financial_experience

      when /skill|habilidad|tecnolog/
        skills

      when /certific/
        certifications

      when /educación|estudios|formación|master|máster/
        education

      when /idioma|inglés|francés|portugués|italiano/
        languages

      when /experiencia|trayectoria|carrera/
        professional_summary

      else
        default_answer
      end
    end

    private

    def ruby_experience
      experience = @profile.experiences.find do |item|
        item.position.match?(/Ruby on Rails/i)
      end

      <<~TEXT
        Arantzazu tiene más de 7 años de experiencia profesional en
        desarrollo de software y una especialización especialmente sólida
        en Ruby on Rails.

        Entre 2020 y febrero de 2026 trabajó como Senior Ruby on Rails
        Engineer y Technical Lead para Caja Rural RSI, desarrollando y
        manteniendo aplicaciones bancarias críticas.

        Sus responsabilidades incluyeron desarrollo de funcionalidades,
        APIs REST, optimización de rendimiento y SQL, refactorización
        aplicando SOLID y Clean Code, resolución de incidencias en
        producción e integración con servicios externos.

        También participó en diseño de soluciones técnicas, code reviews,
        mentoring, coordinación técnica y CI/CD.

        Tecnologías relacionadas:
        Ruby, Ruby on Rails, PostgreSQL, MySQL, Redis, Docker, AWS,
        Jenkins, Git y Capistrano.
      TEXT
    end

    def technical_lead
      <<~TEXT
        Sí. Arantzazu ha desempeñado funciones de Technical Lead durante
        su etapa como Senior Ruby on Rails Engineer.

        Entre sus responsabilidades estuvieron:

        • Diseño de soluciones técnicas.
        • Code reviews.
        • Coordinación técnica del equipo.
        • Planificación y seguimiento de sprints.
        • Priorización y asignación de tareas.
        • Mentoring de desarrolladores.
        • Colaboración con Product Owners y Functional Analysts.
        • Documentación técnica.

        Esta experiencia combina liderazgo técnico con una base sólida
        como desarrolladora Ruby on Rails.
      TEXT
    end

    def pmo_experience
      <<~TEXT
        Desde marzo de 2026, Arantzazu desarrolla funciones de PMO en
        el área de Operations de knowmad mood.

        Sus responsabilidades incluyen:

        • Planificación y seguimiento de proyectos.
        • Capacity planning.
        • Gestión de riesgos.
        • Gestión de dependencias y bloqueos.
        • Seguimiento de KPIs.
        • Reporting ejecutivo.
        • Delivery governance.
        • Seguimiento de incidentes críticos.
        • Coordinación entre Development, Operations y Business.
        • Mejora de procesos y transformación organizativa.

        Esta etapa representa una evolución desde un perfil principalmente
        técnico hacia una posición con una visión transversal de tecnología,
        proyectos y negocio.
      TEXT
    end

    def financial_experience
      <<~TEXT
        Sí. Arantzazu tiene más de seis años de experiencia desarrollando
        aplicaciones críticas para el sector financiero.

        Su experiencia principal corresponde a Caja Rural RSI, donde
        trabajó como Senior Ruby on Rails Engineer y Technical Lead
        desde junio de 2020 hasta febrero de 2026.

        Durante esta etapa trabajó en aplicaciones bancarias críticas,
        APIs REST, bases de datos, rendimiento, integraciones,
        incidencias de producción y despliegues.
      TEXT
    end

    def skills
      grouped = @profile.skills.group_by(&:category)

      grouped.map do |category, category_skills|
        names = category_skills.map(&:name).join(", ")

        "#{category}:\n#{names}"
      end.join("\n\n")
    end

    def certifications
      @profile.certifications
              .order(year: :desc)
              .map do |certification|
        year = certification.year ? " (#{certification.year})" : ""
        "• #{certification.name}#{year}"
      end
              .join("\n")
    end

    def education
      @profile.educations.map do |item|
        "#{item.degree} — #{item.institution} " \
          "(#{item.start_year}-#{item.end_year || "actualidad"})"
      end.join("\n")
    end

    def languages
      @profile.languages.map do |language|
        "• #{language.name}: #{language.level}"
      end.join("\n")
    end

    def professional_summary
      @profile.bio
    end

    def default_answer
      <<~TEXT
        Puedo responder preguntas sobre la trayectoria profesional de
        Arantzazu, incluyendo:

        • Ruby on Rails y desarrollo backend.
        • Technical Leadership.
        • PMO y gestión de proyectos.
        • Experiencia en el sector financiero.
        • Tecnologías y skills.
        • Certificaciones.
        • Formación.
        • Idiomas.
        • Logros profesionales.

        Prueba, por ejemplo:
        "¿Qué experiencia tiene como Technical Lead?"
      TEXT
    end
  end
end