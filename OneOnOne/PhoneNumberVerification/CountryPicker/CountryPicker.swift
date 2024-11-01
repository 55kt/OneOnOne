//
//  CountryPicker.swift
//  OneOnOne
//
//  Created by Vlad on 21/10/24.
//

import SwiftUI

struct CountryPicker: View {
    // MARK: - Properties
    @Binding var selectedCountry: Country
    @State private var showCountryPicker = false
    
    // MARK: - Body
    var body: some View {
        HStack {
            Button(action: {
                showCountryPicker.toggle()
            }) {
                HStack {
                    Text(selectedCountry.flag)
                        .font(.system(size: 24))
                    
                    Text(selectedCountry.code)
                        .fontWeight(.bold)
                        .foregroundStyle(.appSecondaryText)
                    
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.appSecondaryText)
                        .padding(.leading, 5)
                }
                .padding(.horizontal)
            }
            .sheet(isPresented: $showCountryPicker) {
                CountrySelectionView(selectedCountry: $selectedCountry)
            }
        }
    }
}

/*
 Представление для выбора страны
 Country selection
 */
struct CountrySelectionView: View {
    @Binding var selectedCountry: Country
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredCountries, id: \.code) { country in
                    Button(action: {
                        selectedCountry = country
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text(country.flag)
                            Text(country.name)
                                .foregroundStyle(.appSecondaryText)
                            Spacer()
                            Text(country.code)
                                .fontWeight(.bold)
                                .foregroundStyle(.appSecondaryText)
                        }
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search country")
            .navigationTitle("Select Country")
            .animation(.default, value: searchText)
        }
    }
    
    /*
     Фильтрация стран на основе поиска
     Country filtering based on search
     */
    var filteredCountries: [Country] {
        if searchText.isEmpty {
            return allCountries
        } else {
            return allCountries.filter {
                $0.name.lowercased().contains(searchText.lowercased()) || $0.code.contains(searchText)
            }
        }
    }
}

#Preview {
    CountryPicker(selectedCountry: .constant(Country.defaultCountry))
}
