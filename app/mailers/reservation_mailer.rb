# frozen_string_literal: true

class ReservationMailer < ApplicationMailer
  def guest_reservation_create(reservation_id)
    @reservation = Reservation.find(reservation_id)
    @guest = @reservation.guest
    @restaurant = @reservation.restaurant

    mail(
      to: @guest.email,
      subject: 'Reservation Created Successfully',
      from: 'test@test.com'
    )
  end

  def restaurant_reservation_create(reservation_id)
    @reservation = Reservation.find(reservation_id)
    @guest = @reservation.guest
    @restaurant = @reservation.restaurant

    mail(
      to: @restaurant.email,
      subject: 'Reservation Created for your restaurant',
      from: 'test@test.com'
    )
  end

  def guest_reservation_update(changes, reservation_id)
    @reservation = Reservation.find(reservation_id)
    @guest = @reservation.guest
    @restaurant = @reservation.restaurant
    @changes = changes

    mail(
      to: @guest.email,
      subject: 'Reservation Update Successfully',
      from: 'test@test.com'
    )
  end

  def restaurant_reservation_update(changes, reservation_id)
    @reservation = Reservation.find(reservation_id)
    @guest = @reservation.guest
    @restaurant = @reservation.restaurant
    @changes = changes

    mail(
      to: @restaurant.email,
      subject: 'Reservation Updated for your restaurant',
      from: 'test@test.com'
    )
  end
end
