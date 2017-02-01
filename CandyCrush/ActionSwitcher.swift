//
//  ActionSwitcher.swift
//  CandyCrush
//
//  Created by Oleksandr.Bretsko on 2/1/17.
//
//


class ActionSwitcher {

    var recipes: [ Function ]

    init(recipes: [ Function ]){
        self.recipes = recipes
    }

    func perform(function: FunctionName, with args: FunctionData, and returnType: GameDataType) -> Result {

        let funcSignature = FunctionSignature(inputType: args.type, outputType: returnType)

        let funcType = FunctionType(name: function, signature: funcSignature)

        guard let recipe = recipes.filter({ $0.type == funcType }).first else {
            return .Error
        }

        return recipe.execute(with: args)
    }

}




