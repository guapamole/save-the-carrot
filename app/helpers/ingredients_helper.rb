module IngredientsHelper
  def ingredient_img(name)
    begin
      if name == "citron"
        return "ingredient_img/citron.png"
      end

      if name == "concombre"
        return "ingredient_img/concombre.png"
      end

      if name == "citron vert"
        return "ingredient_img/citron-vert.png"
      end

      if name == "lime"
        return "ingredient_img/citron-vert.png"
      end

      if name == "confiture d'orange"
        return "ingredient_img/confiture-orange.png"
      end

      if name == "confiture de fraise"
        return "ingredient_img/confiture-fraise.png"
      end

      if name == "confiture de myrtille"
        return "ingredient_img/confiture-myrtille.png"
      end

      if name == "courgette"
        return "ingredient_img/courgette.png"
      end

      if name == "kiwi"
        return "ingredient_img/kiwi.png"
      end

      if name == "laitue"
        return "ingredient_img/laitue.png"
      end

      if name.match?(/moutarde/)
        return "ingredient_img/moutarde.png"
      end

      if name.match?(/raisin/)
        return "ingredient_img/raisins.png"
      end

      if name == "avocat"
        return "ingredient_img/avocat.png"
      end

      if name == "oignon"
        return "ingredient_img/oignon.png"
      end

      if name == "tomate"
        return "ingredient_img/tomate.png"
      end

      if name == "tomate cerise"
        return "ingredient_img/tomate-cerise.png"
      end
    rescue  ActionView::Template::Error => e
      return "ingredient_img/marmite.png"
    end

    return "marmite.png"
  end
end
