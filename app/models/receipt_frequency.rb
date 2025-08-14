class ReceiptFrequency < ActiveHash::Base
 self.data = [
   { id: 1, name: '---' },
   { id: 2, name: 'スポット' },
   { id: 3, name: '月次' },
   { id: 4, name: '年次' },
   { id: 5, name: 'その他' },
 ]
end