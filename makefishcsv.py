import pandas as pd
import numpy as np

# 재현성을 위한 시드 설정
np.random.seed(42)

# Fish.csv와 동일한 행 수 (예: 159행)
n = 159

# 사용할 컬럼명: Species, Weight, Length1, Length2, Length3, Height, Width
species_list = ['Bream', 'Roach', 'Perch', 'Pike', 'Smelt']
# 임의로 종 선택 (여기서는 'Perch'가 포함되도록 함)
species = np.random.choice(species_list, size=n)

# Weight: 100 ~ 1000 사이의 정수 (그램 단위)
weight = np.random.randint(100, 1000, size=n)

# Length1, Length2, Length3: 10 ~ 50 사이의 실수 (cm 단위)
length1 = np.random.uniform(10, 50, size=n)
length2 = np.random.uniform(10, 50, size=n)
length3 = np.random.uniform(10, 50, size=n)

# Height: 5 ~ 20 사이의 실수
height = np.random.uniform(5, 20, size=n)

# Width: 2 ~ 10 사이의 실수
width = np.random.uniform(2, 10, size=n)

# 데이터프레임 생성
df_another = pd.DataFrame({
    'Species': species,
    'Weight': weight,
    'Length1': length1,
    'Length2': length2,
    'Length3': length3,
    'Height': height,
    'Width': width
})

# CSV 파일로 저장 (index는 제외)
df_another.to_csv('data/AnotherFish.csv', index=False)

print("AnotherFish.csv 파일이 생성되었습니다.")
