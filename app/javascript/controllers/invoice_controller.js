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

 connect() {
    // 編集画面などで初期値をセットするため、初回接続時に計算
    this.recalcTax()
  }

  // 消費税額と合計金額を計算して反映
  recalcTax() {
    // 必須ターゲットが無ければ何もしない
    if (!this.hasNetAmountTarget || !this.hasTaxRateTarget) return

    const net = Number(this.netAmountTarget.value || 0)
    const label = this.taxRateTarget.selectedOptions?.[0]?.textContent || ""
    const rate = this.extractRate(label) // 例: "税率10%" -> 10, "非課税" -> null

    let tax = 0
    if (rate !== null) tax = Math.floor(net * rate / 100)

    if (this.hasTaxAmountTarget) {
      this.taxAmountTarget.value = isFinite(tax) ? tax : ""
    }
    if (this.hasTotalAmountTarget) {
      const total = net + tax
      this.totalAmountTarget.textContent = isFinite(total) ? total.toLocaleString() : "0"
    }
  }

  // "税率10%" → 10, "税率8%" → 8, "非課税" → null
  extractRate(label) {
    const match = label.match(/(\d+(?:\.\d+)?)\s*[%％]/)
    return match ? Number(match[1]) : null
  }
}

