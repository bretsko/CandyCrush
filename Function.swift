//
//  Function.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 2/1/17.
//
//


enum FunctionName: String, CustomStringConvertible {
    case A, B, C

    var description: String {
        return self.rawValue
    }
}

enum BlockType: CustomStringConvertible {
    case VoidVoid( () -> Result )
    case GameDataVoid( ([GameData]) -> Result )
    case VoidGameData( () -> Result )

    func execute (with input: FunctionData) -> Result {

        switch self {
            case .VoidGameData(let block):
                if input.data.first?.type == .Void {
                    return block()
                }
            case .VoidVoid(let block):
                if input.data.first?.type == .CCGameItemMove2D {
                    block()
                    return .OK(nil)
                }
            case .GameDataVoid(let block):
                if input.data.first?.type == .Void {
                    return block(input.data)
                }
        }

        return .Error
    }

    var description: String {
        let value = "" //TODO switch case
        return "value: \(value)"
    }
}


struct FunctionSignature: Hashable, CustomStringConvertible {
    var inputType: GameDataType
    var outputType: GameDataType

    var description: String {
        return "inputType: \(inputType), outputType: \(outputType)"
    }

    var hashValue: Int {
        return inputType.hashValue + outputType.hashValue
    }

    static func == (lhs: FunctionSignature, rhs: FunctionSignature) -> Bool {
        return lhs.inputType == rhs.inputType && lhs.outputType == rhs.outputType
    }
}

//the same func can have several signatures, but also must be hashable - need id? or use multimap
struct FunctionType: Hashable, CustomStringConvertible {

    var name: FunctionName
    var signature: FunctionSignature

    var hashValue: Int {
        return name.hashValue + signature.inputType.hashValue + signature.outputType.hashValue
    }

    var description: String {
        return "name: \(name), signature: \(signature)"
    }

    static func == (lhs: FunctionType, rhs: FunctionType) -> Bool {
        return lhs.name == rhs.name && lhs.signature == rhs.signature
    }
}


struct Function: Equatable, CustomStringConvertible  {

    var type: FunctionType
    var block: BlockType

    func execute (with input: FunctionData) -> Result {
        guard type.signature.inputType == input.type else { return .Error }
        return block.execute (with: input)
    }

    static func == (lhs: Function, rhs: Function) -> Bool {
        return lhs.type == rhs.type
    }

    var description: String {
        return "type: \(type), block: \(block)"
    }
}


class FunctionData: CustomStringConvertible {
    
    var data: [GameData]
    var optional: Bool

    init(data: [GameData], optional: Bool) {
        self.data = data
        self.optional = optional
    }

    var type: GameDataType {
        return data.first?.type ?? .Void
    }

    var description: String {
        return "type: \(type)" //TODO
    }

}



