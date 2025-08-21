import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "clientCode","clientName","invoiceRegNo","qualifiedFlag",
    "netAmount","taxRate","taxAmount","totalAmount",
    "roundingMode","taxAdjust","overrideToggle"
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
    if (this.hasNetAmountTarget && this.hasTaxRateTarget) this.recalcTax()
  }

   toggleOverride() {
    if (!this.hasTaxAmountTarget || !this.hasOverrideToggleTarget) return
    // 手動上書きONなら編集可能、OFFなら読み取り専用
    this.taxAmountTarget.readOnly = !this.overrideToggleTarget.checked
  }

  // 消費税額と合計金額を計算して反映
    recalcTax() {
    if (!this.hasNetAmountTarget || !this.hasTaxRateTarget || !this.hasTaxAmountTarget) return

    const net = Number(this.netAmountTarget.value || 0)

    // 手動上書きがONなら、入力値をそのまま使う（合計だけ更新）
    if (this.hasOverrideToggleTarget && this.overrideToggleTarget.checked) {
      const manualTax = Number(this.taxAmountTarget.value || 0)
      this.updateTotal(net, manualTax)
      return
    }

    // 自動計算ルート
    const label = this.taxRateTarget.selectedOptions?.[0]?.textContent || ""
    const rate = this.extractRate(label)// "税率10%" -> 10, "非課税" -> null

    let tax = 0
    if (rate !== null) {
      const raw = net * rate / 100
      const mode = this.hasRoundingModeTarget ? this.roundingModeTarget.value : "floor"
      tax = this.applyRounding(raw, mode)
    }

    // 調整額を加味（±）
    const adjust = this.hasTaxAdjustTarget ? Number(this.taxAdjustTarget.value || 0) : 0
    const adjustedTax = Math.max(0, tax + adjust) // マイナス防止（必要に応じ外す）

    this.taxAmountTarget.value = isFinite(adjustedTax) ? adjustedTax : ""
    this.updateTotal(net, adjustedTax)
  }


  // "税率10%" → 10, "税率8%" → 8, "非課税" → null
  extractRate(label) {
    const match = label.match(/(\d+(?:\.\d+)?)\s*[%％]/)
    return match ? Number(match[1]) : null
  }

  applyRounding(value, mode) {
    if (mode === "ceil")  return Math.ceil(value)
    if (mode === "round") return Math.round(value)
    return Math.floor(value) // default: 切り捨て
  }

  updateTotal(net, tax) {
    if (!this.hasTotalAmountTarget) return
    const total = Number(net || 0) + Number(tax || 0)
    this.totalAmountTarget.value = isFinite(total) ? total : 0
  }

}

