import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [
        "messages",
        "input",
        "submit",
        "suggestion"
    ]

    connect() {
        this.scrollToBottom()
    }

    submit(event) {
        event.preventDefault()

        console.log("SUBMIT DETECTADO")

        const question = this.inputTarget.value.trim()

        console.log("PREGUNTA:", question)

        if (!question) return

        this.sendQuestion(question)
    }

    useSuggestion(event) {
        const question = event.currentTarget.dataset.question

        if (!question) return

        this.inputTarget.value = question
        this.sendQuestion(question)
    }

    async sendQuestion(question) {
        this.inputTarget.value = ""
        this.setLoading(true)

        this.appendUserMessage(question)
        this.appendLoadingMessage()

        try {
            const response = await fetch("/chat/ask", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    "Accept": "application/json",
                    "X-CSRF-Token": this.csrfToken()
                },
                body: JSON.stringify({
                    question: question
                })
            })

            const data = await response.json()

            this.removeLoadingMessage()

            if (!response.ok) {
                throw new Error(data.error || "Ha ocurrido un error.")
            }

            this.appendAssistantMessage(data.answer)
        } catch (error) {
            this.removeLoadingMessage()

            this.appendAssistantMessage(
                "Lo siento, no he podido procesar la pregunta. Inténtalo de nuevo."
            )

            console.error(error)
        } finally {
            this.setLoading(false)
        }
    }

    appendUserMessage(question) {
        const message = document.createElement("div")

        message.className = "ai-message ai-user-message"

        message.innerHTML = `
      <div class="ai-icon ai-user-icon">
        →
      </div>

      <div class="ai-message-content">
        <p class="ai-label ai-user-label">
          Tú
        </p>

        <p class="ai-message-text">
          ${this.escapeHtml(question)}
        </p>
      </div>
    `

        this.messagesTarget.appendChild(message)

        this.scrollToBottom()
    }

    appendAssistantMessage(answer) {
        const message = document.createElement("div")

        message.className = "ai-message ai-assistant-message"

        message.innerHTML = `
      <div class="ai-icon">
        ✦
      </div>

      <div class="ai-message-content">
        <p class="ai-label">
          Asistente del CV
        </p>

        <div class="ai-message-text">
          ${this.formatAnswer(answer)}
        </div>
      </div>
    `

        this.messagesTarget.appendChild(message)

        this.scrollToBottom()
    }

    appendLoadingMessage() {
        const message = document.createElement("div")

        message.id = "ai-loading-message"
        message.className = "ai-message"

        message.innerHTML = `
      <div class="ai-icon">
        ✦
      </div>

      <div class="ai-message-content">
        <p class="ai-label">
          Asistente del CV
        </p>

        <p class="ai-message-text ai-loading">
          Pensando...
        </p>
      </div>
    `

        this.messagesTarget.appendChild(message)

        this.scrollToBottom()
    }

    removeLoadingMessage() {
        document.getElementById("ai-loading-message")?.remove()
    }

    setLoading(loading) {
        this.submitTarget.disabled = loading

        if (loading) {
            this.submitTarget.textContent = "Enviando..."
        } else {
            this.submitTarget.textContent = "Enviar →"
        }

        this.suggestionTargets.forEach((button) => {
            button.disabled = loading
        })
    }

    csrfToken() {
        return document
            .querySelector('meta[name="csrf-token"]')
            ?.getAttribute("content")
    }

    scrollToBottom() {
        requestAnimationFrame(() => {
            this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
        })
    }

    formatAnswer(answer) {
        return this.escapeHtml(answer)
            .replace(/\n\n/g, "<br><br>")
            .replace(/\n/g, "<br>")
    }

    escapeHtml(value) {
        const div = document.createElement("div")
        div.textContent = value
        return div.innerHTML
    }
}