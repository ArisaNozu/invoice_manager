class ReceiptMethod < ActiveHash::Base
 self.data = [
   { id: 1, name: '---' },
   { id: 2, name: '電子' },
   { id: 3, name: '紙' },
   { id: 4, name: 'その他' },
 ]
end