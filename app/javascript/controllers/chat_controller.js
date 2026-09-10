import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [
        "messages",
        "input",
        "submit",
        "suggestion"
    ]


connect() {
    this.endpoint = this.element.dataset.endpoint || "/chat/ask"
    this.isLoading = false
}

async submit(event) {
    event.preventDefault()

    if (this.isLoading) return

    const question = this.inputTarget.value.trim()

    if (!question) {
        this.inputTarget.focus()
        return
    }

    await this.ask(question)
}

async useSuggestion(event) {
    event.preventDefault()

    if (this.isLoading) return

    const question = event.currentTarget.dataset.question

    if (!question) return

    this.inputTarget.value = question

    await this.ask(question)
}

async ask(question) {
    if (this.isLoading) return

    this.setLoading(true)

    this.appendUserMessage(question)

    this.inputTarget.value = ""

    const loadingMessage = this.appendLoadingMessage()

    try {
        const answer = await this.fetchAnswer(question)

        loadingMessage.remove()

        this.appendAssistantMessage(answer)
    } catch (error) {
        console.error("CV Chat error:", error)

        loadingMessage.remove()

        this.appendAssistantMessage(
            "Lo siento, no he podido procesar la pregunta en este momento. " +
            "Por favor, inténtalo de nuevo."
        )
    } finally {
        this.setLoading(false)
        this.inputTarget.focus()
    }
}

async fetchAnswer(question) {
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

    if (!response.ok) {
        let errorMessage = `HTTP ${response.status}`

        try {
            const data = await response.json()

            if (data.error) {
                errorMessage = data.error
            }
        } catch {
            // La respuesta no era JSON.
        }

        throw new Error(errorMessage)
    }

    const data = await response.json()

    if (!data.answer) {
        throw new Error("The server did not return an answer")
    }

    return data.answer
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

    message.querySelector(".ai-message-text").textContent = question

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

    message.querySelector(".ai-message-text").textContent = answer

    this.messagesTarget.appendChild(message)

    this.scrollToBottom()
}

appendLoadingMessage() {
    const message = document.createElement("div")

    message.className = "ai-message ai-loading-message"

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

    return message
}

setLoading(value) {
    this.isLoading = value

    this.submitTarget.disabled = value
    this.inputTarget.disabled = value

    this.suggestionTargets.forEach((suggestion) => {
        suggestion.disabled = value
    })

    this.submitTarget.textContent = value
        ? "Enviando..."
        : "Enviar →"
}

scrollToBottom() {
    requestAnimationFrame(() => {
        const conversation = this.element.querySelector(
            ".ai-conversation"
        )

        if (!conversation) return

        conversation.scrollTo({
            top: conversation.scrollHeight,
            behavior: "smooth"
        })
    })
}

get csrfToken() {
    const meta = document.querySelector(
        'meta[name="csrf-token"]'
    )

    return meta ? meta.content : ""
}


}
