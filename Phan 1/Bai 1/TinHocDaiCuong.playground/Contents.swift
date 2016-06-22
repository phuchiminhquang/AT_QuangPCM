//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//Phan 1
print("str")

//Bai 1
func VSCau(R: Double) -> (V: Double, S: Double){
    let S = 4 * M_PI * pow(R, 2)
    let V = S * R / 3
    return (V,S)
}

let vsCau = VSCau(2.5)
print("V: \(vsCau.V) S: \(vsCau.S)")

//Bai 2
func F(x: Double , y: Double) -> NSObject {
    let tu = log(abs(x * x - y * y)) / log(5) + atan(x + y)
    let mau = exp(x) + cos(x + y)
    return tu / mau
}

//Bai 5
func tamgiac(a: Double, b: Double, c: Double ) -> (S: Double, P: Double) {
    let P = (a + b + c) / 2
    let S = sqrt(P * (P - a) * (P - b) * (P - c))
    return (S, P)
}



/*----- Phan II ------*/
//Bai 1
func HPT(a: Double, b: Double, c: Double, d: Double, e: Double, f: Double ) -> (nghiem: [Double], message: String) {
    let dinhthuc = a * e - d * b
    let ddx = c * e - f * b
    let ddy = a * f - d * c
    
    if dinhthuc != 0 {
        return ([ddx / dinhthuc , ddy / dinhthuc],"")
    } else if ddx != 0 || ddy != 0 {
        return ([],"HTP vo nghiem")
    } else {
        return ([], "HTP vo dinh")
    }
}

let hpt = HPT(1, b: 2, c: 3, d: -2, e: -5, f: 1)
print("\(hpt.message) \(hpt.nghiem[0])")


//Bai 2
func PTBac2(a: Double, b: Double, c: Double) -> (success: Bool, nghiem: [Double], message: String) {
    let delta = b * b - 4 * a * c
    
    if delta == 0 {
        return (true, [-b / 2 * a], "PTBac 2 co nghiem kep")
    } else if delta > 0 {
        return (true, [(-b - sqrt(delta)) / 2 * a, (-b + sqrt(delta)) / 2 * a],"PTBac 2 co hai nghiem")
    } else {
        return (false, [], "PTBac 2  vo nghiem")
    }
}

let ptbac2 = PTBac2(2, b: -2, c: 1)
if ptbac2.success {
    print("\(ptbac2.message)")
    for nghiem in ptbac2.nghiem {
        print(nghiem)
    }
} else {
    print(ptbac2.message)
}

//Bai 6: Kiem tra tam giac
func isTamgiac(a: Double, b: Double, c: Double) -> (success: Bool, loaiTamgiac: String) {
    func isTamgiacVuong() -> Bool {
        if pow(a, 2) + pow(b, 2) == sqrt(c) || pow(a, 2) + pow(c, 2) == sqrt(b) || pow(c, 2) + pow(b, 2) == sqrt(a) {
            return true
        } else {
            return false
        }
    }
    
    if (a + b > c) && (a + c > b) && (c + b > a) && (a > 0) && (b > 0) && (c > 0) {
        if a == b && b == c {
            return (true, "Tam Giac Deu")
        } else if a == b || b == c || c == a {
            return (true, "Tam Giac Can")
        } else if isTamgiacVuong() {
            return (true, "Tam Giac Vuong")
        } else {
            return (true, "Tam Giac Thuong")
        }
    } else {
        return (false,"")
    }
}

let istamgiac = isTamgiac(2, b: 3, c: 2)
if istamgiac.success {
    print(istamgiac.loaiTamgiac)
} else {
    print("Nhap khong hop le")
}

//Bai 7
func gocAOB(A: [Double], B: [Double], O: [Double]) -> Double {
    
    let OA = sqrt(pow(A[0] - O[0], 2) + pow(A[1] - O[1], 2))
    let OB = sqrt(pow(B[0] - O[0], 2) + pow(B[1] - O[1], 2))
    
    let cosAOB = ((A[0] - O[0]) * (A[1] - O[1]) + (A[1] - O[1]) * (B[1] - O[1])) / (OA * OB)
    
    if cosAOB == 1 {
        return 0
    }
    else if cosAOB == -1 {
        return 180
    }
    else if cosAOB == 0 {
        return 90
    }
    else {
        let tg = sqrt(1 - cosAOB * cosAOB)
        let goc = atan(tg)
        return goc < 0 ? (M_PI/2 - goc) * 180 / M_PI :goc * 180 / M_PI
    }
}
let toado = [
    "A" : [3.0,2.0],
    "B" : [-1.0,3.0],
    "O" : [-2.0,0.0]
]
let gAOB = gocAOB(toado["A"]!, B: toado["B"]!, O: toado["O"]!)


//Bai 9
func englishNameFor(n: Int, option: Bool) -> String {
    var result = ""
    if option {
        switch n {
        case 0:
            result = "zero"
        case 1:
            result = "One"
        case 2:
            result = "Two"
        case 3:
            result = "zero"
        case 4:
            result = "zero"
        case 5:
            result = "zero"
        case 6:
            result = "zero"
        case 7:
            result = "zero"
        case 8:
            result = "zero"
        case 9:
            result = "zero"
        case 10:
            result = "zero"
        default:
            result = "N out of range"
        }
        return result
    } else {
        let dictionary = [
            0: "Zero",
            1: "One",
            2: "Two",
            3: "Three",
            4: "Four",
            5: "Five",
            6: "Six",
            7: "Seven",
            8: "Eight",
            9: "Nine",
            10: "Ten"
        ]
        if n > dictionary.count || n < 0 {
            return "N out of range"
        } else {
            return dictionary[n]!
        }
    }
}

print(englishNameFor(-1, option: false))



//Bai 10 Tinh tien dien
func tienDien(socu: Int, somoi: Int, type: String) -> Int {
    
    let kwhOf = [
        "Ho Dan" : 60,
        "Ho Can Bo" : 90,
        "Ho Kinh Doanh" : 200,
        "Ho San Xuat" : 450,
        ]
    
    let DGDM = 1000
    let GNDM = 2000
    let tieuthu = somoi - socu
    if tieuthu <= kwhOf[type] {
        return tieuthu * DGDM
    } else {
        return (tieuthu - kwhOf[type]!) * GNDM + kwhOf[type]! * DGDM
    }
}

let tien = tienDien(50, somoi: 120, type: "Ho Kinh Doanh")

/*------- Phan III -------*/
//Bai 1
func inBangCuuChuong(n: Int) {
    for i in 1...9 {
        for j in 1...9 {
            print("\(i*j) \t")
        }
        //        print("\n")
    }
}

inBangCuuChuong(3)

//Bai 3
func GaCho() -> (Ga: Int, Cho: Int){
    let tongchan = 100
    let tongdau = 36
    var (soga,socho) = (0,0)
    
    for i in 1...35 {
        for j in 1...35 {
            if (i * 2 + j * 4) == tongchan && (i + j) == tongdau {
                soga = i
                socho = j
            }
        }
    }
    return (soga, socho)
}

var gacho = GaCho()
print("So con ga: \(gacho.Ga), So cho: \(gacho.Cho)")


//Bai 5
func printShape1(height: Int) {
    for row in 1...height {
        var line = ""
        var numberstar = row
        while numberstar > 0 {
            line += "*"
            numberstar -= 1
        }
        print(line)
    }
}
printShape1(5)
print()

func printShape2(height: Int) {
    var row = height
    while row > 0 {
        var line = ""
        var numberstar = row
        while numberstar > 0 {
            line += "*"
            numberstar -= 1
        }
        print(line)
        row -= 1
    }
}


printShape2(5)

func printShape3(height: Int) {
    for row in 1...height {
        var line = ""
        //Print space
        var numberspace = height - row
        while numberspace > 0 {
            line += " "
            numberspace -= 1
        }
        
        //Print *
        var numberstar = (row - 1)*2 + 1
        while numberstar > 0 {
            line += "*"
            numberstar -= 1
        }
        print(line)
    }
}

printShape3(7)


//Bai 6
func caySo(height: Int) {
    for row in 1...height {
        var line = ""
        //Print space
        var numberspace = height - row - 1
        while numberspace > 0 {
            line += " "
            numberspace -= 1
        }
        
        for j in 1...(2*row - 1) {
            if j < row {
                line += (String)((j + row - 1) % 10)
            } else {
                line += (String)((3 * row - j - 1) % 10)
            }
        }
        print(line)
    }
}

//caySo(9)
//Bai 12
func giaithuanhonhat(M: Int) -> Int {
    var n = 0
    var gt = 1
    
    repeat {
        n += 1
        gt *= n
    } while gt <= M
    
    return n
}
//
//print("So nho nhat sao cho n! >= M: \(giaithuanhonhat(20))")


//Bai 13
func TBC_TBN(numbers: Int...) -> (TBC: Double, TBN: Double) {
    var TBC: Double = 0, TBN: Double = 1
    
    for number in numbers {
        TBC += Double(number)
        TBN *= Double(number)
    }
    TBC = TBC / Double(numbers.count)
    TBN = sqrt(TBN)
    
    return (TBC, TBN)
}

//let tbc_tbn = TBC_TBN(1,2,3,4,5)
//print("TBC: \(tbc_tbn.TBC) TBN: \(tbc_tbn.TBN) ")


//Bai 14
func tongchuso(number: Int) -> Int {
    var tmp = number
    var sum = 0
    while tmp > 0 {
        sum += tmp % 10
        tmp = tmp / 10
    }
    return sum
}

//print(tongchuso(12345))

//Bai 15: Liet ke tat ca cac so k bang tong lap phuong cac chu so cua no (k < 1000)
func lietke(k: Int) -> [Int]{
    var count = 0
    var result = [Int]()
    for i in 1...9 {
        for j in 0...9 {
            for k in 0...9 {
                if j * j * j + i * i * i + k * k * k == 100 * i + 10 * j + k {
                    result.append(100 * i + 10 * j + k)
                    count += 1
                }
            }
        }
    }
    return result
}

let numbers = lietke(1000)
var numberStr = ""
for number in numbers {
    numberStr += String(number) + ", "
}
//print(numberStr)


//Bai 16
func isNguyenTo(number: Int) -> Bool {
    switch number {
    case _ where number <= 1:
        return false
    case 2:
        return true
    case 3:
        return false
    default:
        for i in 2...Int(number / 2) {
            if i * i == number {
                return false
            }
        }
    }
    if number <= 1 {
        return false
    } else {
        for i in 2...Int(sqrt(Double(number))) {
            if number % i == 0 {
                return false
            }
        }
    }
    return true
}

//print(isNguyenTo(16))


func timsoNgTo(N: Int, condition: (Int) -> Bool) -> [Int] {
    var result = [Int]()
    for number in 2...N {
        if condition(number) {
            result.append(number)
        }
    }
    return result
}

let daysoNgTo = timsoNgTo(100, condition: isNguyenTo)
numberStr = ""
for soNgTo in daysoNgTo {
    numberStr += String(soNgTo) + ", "
}
//print(numberStr)


//Bai 25: Giai chuong trinh tinh S bang 2 vong lap va in ra ket qua giong nhau
func dayFibo(N: Int) -> [Int] {
    var a = 1, b = 1
    var fibo = [Int]()
    fibo.append(a)
    fibo.append(b)
    
    while b < N {
        let tmp = b
        b = a + b
        a = tmp
        fibo.append(b)
    }
    
    return fibo
}

let daysoFibo = dayFibo(100)
numberStr = ""
for fibo in daysoFibo {
    numberStr += String(fibo) + ", "
}
//print(numberStr)



//Phan IV Chuong Trinh Con
//Bai 1
func giaithua(N: Int) -> Int {
    if N == 1 {
        return 1
    } else {
        return N * giaithua(N-1)
    }
}

func Sin(x: Double) -> Double {
    let epsilon: Double = 0.0001
    var result: Double = 0.0
    let loop: Int = 1
    
    var a: Double = 0
    while fabs(a) >= epsilon {
        let tu: Double = pow(-1.0, Double(loop)) * pow(x, Double(2 * loop - 1))
        let mau: Double = Double(giaithua(2 * loop - 1))
        a = tu / mau
        result += a
    }
    return result
}

//Bai 5: Kiem tra so chinh phuong
func isChinhphuong(N: Int) -> Bool {
    for i in 1...Int(sqrt(Double(N))) {
        if i * i == N {
            return true
        }
    }
    return false
}

//Bai 8
func kiemtraSoBangTongLapPhuong(n: Int) -> Bool{
    var tmp = n
    var sum: Int = 0
    
    while tmp > 0 {
        sum += Int(pow(Double(tmp%10), 3))
        tmp = tmp / 10
    }
    return sum == n
}

//print(kiemtraSoBangTongLapPhuong(153))

//--------------------------- Phan De Quy
//Bai 10 de quy tinh S
func dequyS(a: Int, n: Int) -> Double {
    if n == 0 {
        return 0
    } else {
        return 1 / pow(Double(a), Double(n)) + dequyS(a, n: n-1)
    }
}

//print(dequyS(1, n: 2))

//Bai 12
//Căn bậc n của i
func squareRootOf(x: Double, n: Int) -> Double {
    let epsilon: Double = 0.001
    
    if x == 0 {
        return 0
    }
    
    var y0 = x
    var y: Double = 0
    repeat {
        y = y0
        y0 = 1 / Double(n) * (Double(n - 1) * y + (x / pow(y, Double(n-1))))
        
    } while abs(y - y0) < epsilon
   
    return (y + y0) / 2
}

func dequyS1(n: Int) -> Double{
    if n == 1 {
        return 1
    } else {
        return Double(n) / squareRootOf(Double(n), n: n) + dequyS1(n - 1)
    }
}

//print(dequyS1(2))


//Bai 15 USCLN va BSCBN

func USCLN(x: Int, y: Int) -> Int {
    var a = abs(x)
    var b = abs(y)
    
    while a != 0 && b != 0 {
        if a > b {
            a -= b
        } else {
            b -= a
        }
    }
    return a == 0 ? b : a
}

func BSCNN(x: Int, y: Int) -> Int {
    return x * y / USCLN(x, y: y)
}

func TinhUSCLNvaBSCBN(x: Int, y: Int) -> (USCLN: Int, BSCNN: Int) {
    let uscln = USCLN(x, y: y)
    return (uscln, x * y / uscln)
}


//Bai 16: Nhap so nguyen tu ban phim va in ra co so bat ky (2-16)
func doicoso(n: Int, coso: Int) -> String {
    var so = n
    var result = [Int]()
    while so > 0 {
        result.append(so%coso)
        print(so%coso)
        so /= coso
    }
    
    var number = ""
    if result.count > 0 {
        for i in 0..<result.count {
            number += String(result[i])
        }
    }
    
    print(number)
    return number
}

//doicoso(8, coso: 2)


//Bai 19: tim so Kaprekar

func fillInArray(n: Int) -> [Int] {
    var result = [Int]()
    var number = n
    while number > 0 {
        result.append(number % 10)
        number = number / 10
    }
    return result
}

func convertArray(numbers: [Int]) -> [Int] {
    var increasedNumbers = numbers
    
    for i in 0..<numbers.count {
        for j in 0..<numbers.count {
            if increasedNumbers[i] > increasedNumbers[j] {
                let tmp = increasedNumbers[i]
                increasedNumbers[i] = increasedNumbers[j]
                increasedNumbers[j] = tmp
            }
        }
    }
    return increasedNumbers
}

func isKarperkar(n: Int) -> Bool {
    let sortedArray = convertArray(fillInArray(n))
    
    var min = 0
    var max = 0
    
    for i in 0..<sortedArray.count {
        min = min*10 + sortedArray[i]
        max = max*10 + sortedArray[sortedArray.count - i - 1]
    }
//    print("\(max) \(min)")
    return max - min == n ? true : false
 }

func printKarperkarLessThan(n: Int) -> String {
    var str = ""
    for i in 10..<n {
        if isKarperkar(i) {
            str += String(i)
        }
    }
    return str
}

//printKarperkarLessThan(500)

//Bai 20: Kiem tra n co phai la so fibo

func isFibo(n: Int) -> Bool {
    var a: Int = 1, b: Int = 1
    while (b < n) {
        let tmp = b
        b += a
        a = tmp
    }
    return b == n
}

//print(isFibo(8))

//------ PHAN V: Kieu Mang



























