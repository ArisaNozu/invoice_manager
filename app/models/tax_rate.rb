class TaxRate < ActiveHash::Base
 self.data = [
   { id: 1, name: '---' },
   { id: 2, name: '税率10%' },
   { id: 3, name: '税率8%' },
   { id: 4, name: '税率5%' },
   { id: 5, name: '非課税' },
   { id: 6, name: '課税対象外' }
 ]
end