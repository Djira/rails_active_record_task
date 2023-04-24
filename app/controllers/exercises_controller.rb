class ExercisesController < ApplicationController
  def exercise1
    # [Pour renvoyer tous les plats non commandés.
    # Utilisez left_outer_joins.
    @foods = Food
    .left_outer_joins(:order_foods)
    .distinct.where(order_foods:{id: nil})
  end

  def exercise2
    # [Pour retourner tous les magasins qui servent de la nourriture qui n'a pas été commandée.
    # Pour utiliser left_outer_joins.
    @shops = Shop
    .left_outer_joins(foods: :order_foods)
    .distinct.where(foods:{order_foods:{id: nil}})
  end

  def exercise3 
    # [Pour renvoyer l'adresse de livraison la plus fréquente.
    # Pour utiliser les jointures.
    # Renvoyer le nombre de commandes lors de l'appel de orders_count sur une instance de l'adresse acquise.
    @address = Address
    .joins(:orders)
    .select("adresse.*,COUNT(orders.*)orders_count")
    .group("addresses.id")
    .order("orders_count DESC")
    .first
  end

  def exercise4 
    # [Pour retourner les clients qui dépensent le plus d'argent.
    # Pour utiliser les jointures.
    # Renvoyer le montant total de l'argent lors de l'appel à foods_price_sum sur l'instance de client récupérée.
    @customer = Customer
    .joins("order: :foods")
    .select("customers.*, SUM(foods.price) AS foods_price_sum")
    .group("customers.id")
    .order("foods_price_sum DESC")
    .first
  end
end
