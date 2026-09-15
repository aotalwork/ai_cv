import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["messages", "input", "submit"]

    connect() {
        console.log("🔥 CHAT STIMULUS CONECTADO")

        this.endpoint = this.element.dataset.endpoint || "/chat/ask"
        this.isLoading = false
    }

    async submit(event) {
        event.preventDefault()
        event.stopPropagation()

        console.log("🔥 SUBMIT INTERCEPTADO")

        const question = this.inputTarget.value.trim()

        if (!question || this.isLoading) {
            return
        }

        await this.ask(question)
    }

    async ask(question) {
        console.log("📤 Enviando:", question)

        this.setLoading(true)

        this.appendUserMessage(question)

        this.inputTarget.value = ""

        try {
            const body = new URLSearchParams()

            body.append("question", question)

            const response = await fetch(this.endpoint, {
                method: "POST",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: body.toString()
            })

            console.log("📥 HTTP:", response.status)

            const data = await response.json()

            console.log("🤖 Respuesta:", data)

            if (!response.ok) {
                throw new Error(
                    data.error || "Error al procesar la pregunta."
                )
            }

            this.appendAssistantMessage(data.answer)

        } catch (error) {
            console.error("❌ Error:", error)

            this.appendAssistantMessage(
                "No he podido procesar la pregunta. Inténtalo de nuevo."
            )

        } finally {
            this.setLoading(false)
            this.inputTarget.focus()
        }
    }

    useSuggestion(event) {
        event.preventDefault()

        const question = event.currentTarget.dataset.question

        if (!question || this.isLoading) {
            return
        }

        console.log("💡 Pregunta sugerida:", question)

        this.inputTarget.value = question
        this.inputTarget.focus()
    }

    appendUserMessage(question) {
        const message = document.createElement("div")

        message.className = "ai-message ai-user-message"

        message.innerHTML = `
            <div class="ai-icon ai-user-icon">
                ●
            </div>

            <div class="ai-message-content">
                <p class="ai-label ai-user-label">
                    Tú
                </p>

                <p class="ai-message-text"></p>
            </div>
        `

        message
            .querySelector(".ai-message-text")
            .textContent = question

        this.messagesTarget.appendChild(message)

        this.scrollToBottom()
    }

    appendAssistantMessage(answer) {
        const message = document.createElement("div")

        message.className = "ai-message"

        message.innerHTML = `
            <div class="ai-icon">
                ✦
            </div>

            <div class="ai-message-content">
                <p class="ai-label">
                    Asistente del CV
                </p>

                <p class="ai-message-text"></p>
            </div>
        `

        message
            .querySelector(".ai-message-text")
            .textContent = answer || "No se ha recibido ninguna respuesta."

        this.messagesTarget.appendChild(message)

        this.scrollToBottom()
    }

    setLoading(value) {
        this.isLoading = value

        this.inputTarget.disabled = value
        this.submitTarget.disabled = value

        this.submitTarget.textContent = value
            ? "Enviando..."
            : "Enviar →"
    }

    scrollToBottom() {
        requestAnimationFrame(() => {
            this.messagesTarget.scrollIntoView({
                behavior: "smooth",
                block: "end"
            })
        })
    }
}