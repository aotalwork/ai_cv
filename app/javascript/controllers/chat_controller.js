import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["messages", "input", "submit", "suggestion"]

    connect() {
        console.log("Chat controller conectado")
        this.endpoint = "/chat/ask"
        this.isLoading = false
    }

    async submit(event) {
        event.preventDefault()

        console.log("Submit ejecutado")

        if (this.isLoading) return

        const question = this.inputTarget.value.trim()

        if (!question) return

        await this.ask(question)
    }

    async ask(question) {
        console.log("Enviando pregunta:", question)

        this.setLoading(true)

        this.appendUserMessage(question)
        this.inputTarget.value = ""

        try {
            const response = await fetch(this.endpoint, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "Accept": "application/json",
                    "X-CSRF-Token": this.csrfToken
                },
                body: JSON.stringify({
                    question: question
                })
            })

            console.log("HTTP:", response.status)

            const data = await response.json()

            console.log("Respuesta:", data)

            if (!response.ok) {
                throw new Error(data.error || "Error en el servidor")
            }

            this.appendAssistantMessage(data.answer)
        } catch (error) {
            console.error("Error:", error)

            this.appendAssistantMessage(
                "No he podido procesar la pregunta. Inténtalo de nuevo."
            )
        } finally {
            this.setLoading(false)
            this.inputTarget.focus()
        }
    }

    appendUserMessage(question) {
        const message = document.createElement("div")

        message.className = "ai-message ai-user-message"

        message.innerHTML = `
      <div class="ai-icon ai-user-icon">●</div>

      <div class="ai-message-content">
        <p class="ai-label ai-user-label">Tú</p>
        <p class="ai-message-text"></p>
      </div>
    `

        message.querySelector(".ai-message-text").textContent = question

        this.messagesTarget.appendChild(message)
    }

    appendAssistantMessage(answer) {
        const message = document.createElement("div")

        message.className = "ai-message"

        message.innerHTML = `
      <div class="ai-icon">✦</div>

      <div class="ai-message-content">
        <p class="ai-label">Asistente del CV</p>
        <p class="ai-message-text"></p>
      </div>
    `

        message.querySelector(".ai-message-text").textContent = answer

        this.messagesTarget.appendChild(message)
    }

    setLoading(value) {
        this.isLoading = value

        this.submitTarget.disabled = value
        this.inputTarget.disabled = value

        this.submitTarget.textContent = value
            ? "Enviando..."
            : "Enviar →"
    }

    get csrfToken() {
        return document.querySelector(
            'meta[name="csrf-token"]'
        )?.content || ""
    }
}