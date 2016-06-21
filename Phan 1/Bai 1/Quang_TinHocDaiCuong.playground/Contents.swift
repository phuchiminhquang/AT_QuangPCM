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


////Bai 6
//func caySo(height: Int) {
//    let numbers = [0,1,2,3,4,5,6,7,8,9]
//    for row in 0..<height {
//        var line = ""
//        //Print space
//        var numberspace = height - row
//        while numberspace > 0 {
//            line += " "
//            numberspace -= 1
//        }
//
//        var leftFirstNumber = row + 1
//        while
//        for leftFirstNumber in row...(row * 2 + 1) {
//            line += String(numbers[leftFirstNumber%10+1])
//        }
//
////        var nextnumber = row * 2
////        while nextnumber > 0 {
////            line += String(numbers[nextnumber%10])
////            nextnumber -= 1
////        }
//
//        print(line)
//    }
//}

//caySo(9)


















