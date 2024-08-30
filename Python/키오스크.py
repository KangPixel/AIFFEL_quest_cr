#메뉴와 가격 리스트를 다차원 리스트로 변경하기
# 메뉴 출력 enumerate() 함수 활용하기
# datetime 모듈로 주문표에 주문 일시 추가하기 ✔
# 데코레이터로 주문표 양식 출력하기
from datetime import datetime

menu = ['americano', 'latte', 'mocha', 'yuza_tea', 'green_tea', 'choco_latte']
price = [2000, 3000, 3000, 2500, 2500, 3000]

class Kiosk:
    def __init__(self):
        self.menu = menu
        self.price = price
        self.price_sum = 0

    # 메뉴 출력 메서드
    def menu_print(self):
        for i in range(len(self.menu)):
            print(i + 1, self.menu[i], ':', self.price[i], '원')

    # 주문 메서드
    def menu_select(self):
        self.order_menu = []
        self.order_price = []
        n = 0
        # 첫 주문
        while n <1 or len(self.menu) < n:
            try:
                n = int(input('음료의 번호를 입력하세요 : '))
            except ValueError:
                print('\'번호\'로 입력하세요.')
            
            if 1 <= n and n <= len(self.menu):
                self.order_price.append(self.price[-1])
                self.price_sum += self.price[n-1]
            else:
                print('없는 메뉴입니다. 다시 주문해 주세요.')

        #온도 확인
        t = 0
        while t != 1 and t != 2:
            try:
                t = int(input('HOT 음료는 1을, ICE 음료는 2를 입력하세요 : '))
            except ValueError:
                pass
            
            if t == 1:
                self.temp = 'HOT'
            elif t == 2:
                self.temp = 'ICE'
            else:
                print('1과 2 중 하나를 입력하세요.')
        self.order_menu.append(self.temp + ' ' + self.menu[n-1])
        print(self.temp, self.menu[n-1], ':', self.price[n-1], '원')

        # 추가주문
        while n != 0:
            print()
            try:
                n = int(input('추가 주문은 음료 번호를, 지불은 0을 입력하세요 : '))
                if 1 <= n and n <= len(self.menu):
                    t = 0
                    while t != 1 and t != 2:
                        try:
                            t = int(input('HOT 음료는 1을, ICE 음료는 2를 입력하세요 : '))
                        except ValueError:
                            pass
                        if t == 1:
                            self.temp = 'HOT'
                        elif t == 2:
                            self.temp = 'ICE'
                        else:
                            print('1과 2 중 하나를 입력하세요.')
                    self.order_price.append(self.price[n-1])
                    self.order_menu.append(self.temp + ' ' + self.menu[n-1])
                    self.price_sum += self.price[n-1]
                elif n == 0:
                    print('주문이 완료되었습니다.')
                    print(self.order_menu, self.order_price)
                else:
                    print('없는 메뉴입니다. 다시 주문해 주세요.')
            except ValueError:
                print('\'번호\'로 입력하세요.')
            
    # 지불
    def pay(self):
        payment = 0
        print()
        while True:
            print('지불할 금액: ', self.price_sum, '원')
            payment = input('지불 수단을 고르세요(현금:\'cash\' or 1, 카드:\'card\' or 2) : ')

            if payment == 'cash' or payment == '1':
                print('직원을 호출하겠습니다.')
                break
            elif payment == 'card' or payment == '2':
                print('IC칩 방향에 맞게 카드를 꽂아주세요.')
                break
            else:
                print('다시 결제를 시도해 주세요.')

    # 주문서 출력 
    def table(self):
        print('⟝' + '-' * 38 + '⟞')
        for i in range(5):
            print('|' + ' ' * 39 + '|')
        for i in range(len(self.order_menu)):
            print('|    ', self.order_menu[i], ' : ', self.order_price[i], '\t\t|')

        print('|     합계 금액 :', self.price_sum, '\t\t|')
        print('|' + ' ' * 39+ '|')
        print('|주문 일시:',datetime.now(),'\t|')
        for i in range(4):
            print('|' + ' ' * 39+ '|')
        print('⟝' + '-' * 38 + '⟞')

a = Kiosk()  # 객체 생성 
a.menu_print()  # 메뉴 출력
a.menu_select()  # 주문
a.pay()  # 지불
a.table()  # 주문표 출력