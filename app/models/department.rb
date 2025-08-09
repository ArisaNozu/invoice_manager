class Department < ActiveHash::Base
 self.data = [
   { id: 1, name: '---' },
   { id: 2, name: '営業部' },
   { id: 3, name: '開発部' },
   { id: 4, name: '総務部' },
   { id: 5, name: '人事部' },
   { id: 6, name: '経理部' }
 ]
end