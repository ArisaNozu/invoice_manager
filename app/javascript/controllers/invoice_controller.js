import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "clientCode", "clientName", "invoiceRegNo", "qualifiedFlag",
    "netAmount", "taxRate", "taxAmount", "totalAmount"
  ]

  // 取引先情報の取得
  async fetchClientInfo() {
    const code = this.clientCodeTarget?.value?.trim()
    if (!code) { this.clearClientDisplay(); return }
    const res = await fetch(`/clients/lookup?client_code=${encodeURIComponent(code)}`, {
      headers: { Accept: "application/json" }
    })
    if (!res.ok) { this.clearClientDisplay(); return }
    const data = await res.json()
    this.clientNameTarget.textContent = data.name || "-"
    this.invoiceRegNoTarget.textContent = data.invoice_registration_number || "-"
    this.qualifiedFlagTarget.textContent = data.is_qualified_invoice_issuer ? "適格事業者" : "非適格"
  }

  clearClientIfEmpty() {
    if (!this.clientCodeTarget.value?.trim()) this.clearClientDisplay()
  }

  clearClientDisplay() {
    this.clientNameTarget.textContent = "------"
    this.invoiceRegNoTarget.textContent = "--------------"
    this.qualifiedFlagTarget.textContent = "------"
  }
}
