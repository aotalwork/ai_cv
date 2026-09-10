# Limpiamos los datos anteriores para poder ejecutar seeds varias veces
Recommendation.destroy_all
Achievement.destroy_all
Language.destroy_all
Education.destroy_all
Certification.destroy_all
Skill.destroy_all
Project.destroy_all
Experience.destroy_all
Profile.destroy_all

profile = Profile.create!(
  name: "Arantzazu Otal Alberro",
  headline: "Senior Ruby on Rails Engineer | PMO | Technical Lead",
  bio: <<~BIO,
    Senior Ruby on Rails Engineer con más de 7 años de experiencia
    desarrollando aplicaciones críticas para el sector financiero.

    Evolución profesional desde Software Engineer hacia Senior Ruby on Rails
    Engineer, Technical Lead y PMO, combinando experiencia técnica,
    liderazgo técnico, coordinación Agile y gestión de proyectos.

    Desde marzo de 2026 desarrolla funciones de PMO en el área de Operations
    de knowmad mood, participando en planificación, seguimiento y gobierno
    de proyectos tecnológicos, capacity planning, riesgos, dependencias,
    indicadores y reporting ejecutivo.

    Combina una sólida base técnica con liderazgo y gestión, actuando como
    puente entre Development, Operations y Business.
  BIO
  location: "Jerez de la Frontera, Cádiz, España",
  email: "aotalwork@gmail.com",
  phone: "+34 639011609",
  linkedin_url: "https://linkedin.com/in/arantzazu-otal-035928190",
  github_url: "https://github.com/aotalwork?tab=repositories"
)

# ============================================================
# EXPERIENCIA
# ============================================================

profile.experiences.create!(
  company: "knowmad mood",
  position: "PMO — Operations Area",
  client: "Interno",
  description: <<~DESC,
    Seguimiento de planificación de proyectos, gestión de riesgos,
    dependencias y bloqueos, capacity planning, creación y seguimiento
    de KPIs, reporting ejecutivo y coordinación transversal entre
    Development, Operations y Business.

    Seguimiento de incidentes críticos, delivery governance,
    definición y mejora de procesos y soporte a iniciativas
    de transformación organizativa.
  DESC
  start_date: Date.new(2026, 3, 1),
  end_date: nil,
  technologies: "Jira, Jira Service Management, Confluence, Loom, Copilot, Excel, Project Planner, Teams, Notes",
  company_url: "https://www.knowmadmood.com"
)

profile.experiences.create!(
  company: "knowmad mood",
  position: "Senior Ruby on Rails Engineer | Technical Lead",
  client: "Caja Rural RSI",
  description: <<~DESC,
    Desarrollo y mantenimiento de aplicaciones bancarias críticas
    utilizando Ruby on Rails.

    Desarrollo de nuevas funcionalidades, APIs REST, optimización
    de rendimiento y SQL, refactorización aplicando SOLID y Clean Code,
    resolución de incidencias en producción e integración con servicios
    externos.

    Diseño de soluciones técnicas, code reviews, coordinación técnica
    del equipo, planificación y seguimiento de sprints, priorización
    y asignación de tareas, mentoring de desarrolladores,
    colaboración con Product Owners y Functional Analysts y
    elaboración de documentación técnica.

    También participación en pipelines de CI/CD y despliegues.
  DESC
  start_date: Date.new(2020, 6, 1),
  end_date: Date.new(2026, 2, 28),
  technologies: "Ruby, Ruby on Rails, PostgreSQL, MySQL, Redis, Docker, AWS, Jenkins, Git, Capistrano",
  company_url: "https://www.knowmadmood.com"
)

profile.experiences.create!(
  company: "knowmad mood",
  position: "Software Engineer",
  client: "Autovidal",
  description: <<~DESC,
    Desarrollo y mantenimiento de una plataforma de gestión de flotas
    basada en Java EE.

    Participación en desarrollo de funcionalidades y evolución
    de la plataforma.
  DESC
  start_date: Date.new(2020, 2, 1),
  end_date: Date.new(2020, 6, 1),
  technologies: "Java, Spring Boot MVC, JSF, Oracle, SQL, Git, Maven, Gradle, JPA, Hibernate, J2EE",
  company_url: "https://www.knowmadmood.com",
  project_url: "https://autovidal.es/"
)

profile.experiences.create!(
  company: "Universidad de Cádiz",
  position: "Software Developer",
  description: <<~DESC,
    Participación en proyectos de investigación y desarrollo.

    Desarrollo de algoritmos para análisis y predicción de mareas
    utilizando C++.

    Desarrollo, dirección técnica y testing de una plataforma
    de comercio electrónico con integración de pasarela de pago.
  DESC
  start_date: Date.new(2018, 1, 1),
  end_date: Date.new(2019, 12, 31),
  technologies: "C++, E-Commerce, Payment Gateway",
  company_url: "https://ucatidex2020.wordpress.com/"
)

# ============================================================
# SKILLS
# ============================================================

backend_skills = [
  "Ruby",
  "Ruby on Rails",
  "REST APIs",
  "PostgreSQL",
  "MySQL",
  "Redis",
  "Sidekiq",
  "Docker",
  "AWS",
  "CI/CD",
  "SOLID",
  "Clean Code",
  "Performance Optimization",
  "Tailwind CSS"
]

backend_skills.each do |skill|
  profile.skills.create!(
    name: skill,
    category: "Backend & Engineering"
  )
end

leadership_skills = [
  "Technical Leadership",
  "Team Coordination",
  "Sprint Planning",
  "Agile Coaching",
  "Technical Mentoring",
  "Code Reviews",
  "Estimation",
  "Technical Documentation"
]

leadership_skills.each do |skill|
  profile.skills.create!(
    name: skill,
    category: "Technical Leadership"
  )
end

management_skills = [
  "PMO",
  "Delivery Management",
  "Project Coordination",
  "Stakeholder Management",
  "Executive Reporting",
  "KPI Monitoring",
  "Risk Management",
  "Dependency Management",
  "Capacity Planning",
  "Continuous Improvement"
]

management_skills.each do |skill|
  profile.skills.create!(
    name: skill,
    category: "Project Management"
  )
end

# ============================================================
# CERTIFICACIONES
# ============================================================

certifications = [
  ["Atlassian Credentialed in Forge Fundamentals", 2026, nil],
  ["Atlassian Credentialed in Loom Fundamentals", 2026, nil],
  ["Atlassian Credentialed in JSM Fundamentals with AI", 2026, nil],
  ["Atlassian Credentialed in Rovo Fundamentals", 2026, nil],
  ["Generative AI Applied to Development ED2", 2026, nil],
  ["AWS Certified Cloud Practitioner course", 2025, nil],
  ["Scrum Master Certified (SMC®)", 2024, "https://www.europeanscrum.org/european-scrum-arantzazu-otal-alberro.html"],
  ["Scrum Product Owner Certified (SPOC®)", 2024, "https://www.europeanscrum.org/european-scrum-arantzazu-otal-alberro.html"],
  ["ITIL® 4 Foundation", 2024, nil],
  ["Líder Coach", 2024, nil],
  ["SAFe® Agilist 6.0 course", 2023, nil],
  ["Cisco CCNP Routing", nil, nil],
  ["Cisco CCNA Switching", nil, nil]
]

certifications.each do |name, year, url|
  profile.certifications.create!(
    name: name,
    year: year,
    url: url
  )
end

# ============================================================
# EDUCACIÓN
# ============================================================

profile.educations.create!(
  institution: "Universidad de Castilla-La Mancha",
  degree: "Master in Artificial Intelligence",
  start_year: 2026,
  end_year: nil
)

profile.educations.create!(
  institution: "Universidad de Cádiz",
  degree: "Grado en Ingeniería Informática — Especialidad TIC",
  start_year: 2014,
  end_year: 2020
)

# ============================================================
# IDIOMAS
# ============================================================

[
  ["Español", "Nativo"],
  ["Inglés", "B2 — Professional Working Proficiency"],
  ["Francés", "A2"],
  ["Portugués", "A1/A2"],
  ["Italiano", "A1/A2"]
].each do |name, level|
  profile.languages.create!(
    name: name,
    level: level
  )
end

# ============================================================
# LOGROS DESTACADOS
# ============================================================

achievements = [
  "Más de seis años desarrollando aplicaciones críticas para el sector financiero.",
  "Evolución profesional desde Software Engineer hasta Senior Ruby on Rails Engineer, Technical Lead y PMO.",
  "Coordinación de equipos multidisciplinares bajo metodologías Agile.",
  "Experiencia en delivery governance, planificación, capacity planning, gestión de riesgos y reporting ejecutivo.",
  "Trabajo transversal entre Development, Operations y Business.",
  "Participación en iniciativas de mejora continua y transformación organizativa.",
  "Formación continua en cloud, Agile, Inteligencia Artificial y ecosistema Atlassian."
]

achievements.each_with_index do |description, index|
  profile.achievements.create!(
    title: "Achievement #{index + 1}",
    description: description,
    position: index + 1
  )
end

# ============================================================
# RECOMENDACIÓN PROFESIONAL
# ============================================================

profile.recommendations.create!(
  author: "Fátima Zel-lal Prieto",
  author_role: "Head of People",
  company: "knowmad mood",
  date: Date.new(2026, 8, 20),
  summary: <<~SUMMARY,
    Recomendación profesional que destaca la capacidad de adaptación
    de Arantzazu, su evolución desde una posición eminentemente técnica
    hacia responsabilidades con una visión más global de tecnología,
    proyectos y negocio.
  SUMMARY
  content: <<~CONTENT
    Durante su trayectoria en knowmad mood, Arantzazu ha trabajado para
    diferentes clientes, entre ellos Autovidal y RSI, desarrollando
    principalmente funciones técnicas como desarrolladora de software,
    con especialización en Ruby on Rails.

    Posteriormente amplió su ámbito de colaboración dentro del
    departamento interno de Delivery, participando en la revisión y
    validación de ofertas comerciales y técnicas antes de su presentación
    a clientes.

    Esta experiencia le permitió combinar su conocimiento técnico con
    una perspectiva orientada a las necesidades del cliente, la
    viabilidad de las propuestas y los criterios de calidad de las
    soluciones planteadas.

    Se destaca especialmente su capacidad de adaptación, compromiso,
    capacidad de trabajo en equipo y disposición para asumir nuevos
    retos y responsabilidades.

    Se recomienda a Arantzazu para futuras oportunidades profesionales,
    destacando que puede aportar valor tanto en posiciones técnicas como
    en aquellas que requieran una visión transversal entre tecnología,
    proyectos y necesidades de negocio.
  CONTENT
)

puts "CV cargado correctamente."
puts "Profile: #{profile.name}"
puts "Experiencias: #{profile.experiences.count}"
puts "Skills: #{profile.skills.count}"
puts "Certificaciones: #{profile.certifications.count}"
puts "Educación: #{profile.educations.count}"
puts "Idiomas: #{profile.languages.count}"
puts "Logros: #{profile.achievements.count}"
puts "Recomendaciones: #{profile.recommendations.count}"